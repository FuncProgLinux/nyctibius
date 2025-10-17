#!/usr/bin/env perl
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2025 Urutau-Ltd <softwarelibre@urutau-ltd.org>
use v5.36;
use File::Find;
use List::Util qw(min);
use Readonly;
Readonly::Scalar my $MAX_PROCESSES => 8;

use utf8;
use open qw( :std :encoding(UTF-8));

our $VERSION = version->declare("v1.0.0");

sub worker($file) {
  system("guix style -f $file 2>&1");
  exit 0;
}

say "Searching and formatting Guix scheme code...";

my @files_to_format;
find({
    wanted => sub {
        push @files_to_format, $File::Find::name if /\.scm$/;
    },
    no_chdir => 1
}, '.');

my $total_files = scalar @files_to_format;

say "Found $total_files to format!";

my @pids;
my $running_processes = 0;
my $formatted_files = 0;

FILE:
foreach my $file (@files_to_format) {
    if ($running_processes >= $MAX_PROCESSES) {
        my $pid = waitpid(-1, 0);
        if ($pid > 0) {
            $running_processes--;
            $formatted_files++;

            my $perc = int(($formatted_files / $total_files) * 100);
            printf "\rProgress: %d of %d formatted files. [%-50s] %d%%",
              $formatted_files, $total_files, "#" x int($perc / 2), $perc;
        }
    }

    my $pid = fork();

    if ($pid == 0) {
        worker($file);
    }
    elsif ($pid > 0) {
        push @pids, $pid;
        $running_processes++;
    }
    else {
        die "Unable to create a new fork: $!";
    }
}

while (my $pid = waitpid(-1, 0)) {
    last if $pid == -1;
    $running_processes--;
    $formatted_files++;
    my $perc = int(($formatted_files / $total_files) * 100);
    printf "\rProgress: %d of %d formatted files. [%-50s] %d%%",
      $formatted_files, $total_files, "#" x int($perc / 2), $perc;
}
printf "\r%-100s", "";
say "";
say "Finished formatting Guix Scheme files!";

__END__

=encoding utf8

=head1 NAME

pfmt.pl - Forking formatter of Guix Scheme files.

=head1 SYNOPSIS

pfmt

=head1 DESCRIPTION

pfmt is a perl script designed to search, find and format Guile Scheme source
code files leveraging C<guix style> concurrently. The script uses a forking
model to format files in parallel.

The script controls a fixed number of concurrent processes defined by the
constant C<MAX_PROCESSES> at the start of the script, if this limit is reached,
the main process waits until any of the worker processes finishes before
spawning a new one. This is to avoid overloading the system, but it's up to
the user to fine-tune this value.

=head1 CONSIDERATIONS

=over 4

=item Speed isn't free

Unlike C<xargs> this script gives you a bit more control over the number of
processes. The higher the value you set for MAX_PROCESSES the faster the
formatting will finish, however, depending on your CPU, the usage can create
spikes. Setting the value to C<100> running inside an Intel Xeon processor
finishes in C<0m2.145s> for 77 guix scheme files.

=item Absence of pipes overhead

Using pipes can introduce a small amount of I/O & buffer overhead. Managing
forks concurrently inside the scripts avoids this layer of abstraction.

=back

=head1 AUTHOR & COPYING

Urutaú Limited <softwarelibre@urutau-ltd.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.

=cut
