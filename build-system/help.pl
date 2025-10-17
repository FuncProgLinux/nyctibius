#!/usr/bin/env perl
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright © 2024-2025 Urutau-Ltd <softwarelibre@urutau-ltd.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the  GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
use v5.36;

use utf8;
use open qw( :std :encoding(UTF-8));
use POSIX;

use Getopt::Long;
use Pod::Usage;

use Readonly;
Readonly::Scalar my $RED => "\e[31m";
Readonly::Scalar my $GREEN => "\e[32m";
Readonly::Scalar my $YELLOW => "\e[33m";
Readonly::Scalar my $BLUE => "\e[34m";
Readonly::Scalar my $PURPLE => "\e[35m";
Readonly::Scalar my $RESET => "\e[0m";

our $VERSION = version->declare("v1.1.0");

my $help = 0;
my $verbose_help = 0;

GetOptions(
           'help|?' => \$help,
           'man|longhelp|??' => \$verbose_help,
) or pod2usage(2);

pod2usage(1) if $help;
pod2usage(-verbose => 2) if $verbose_help;

=pod
Call this subroutine instead of printing the main help menu inside the
GNU Makefile. It should parse and pretty-print the comment annotations for you.

=cut
sub main_help($files) {
  say $YELLOW.
    "=== [Nyctibius".
    $GREEN.
    " GNU MAKEFILE + PERL ".
    $YELLOW.
    " BUILD SYSTEM v1.0.0] ===".
    $RESET;
  say "";
  say "Usage:";
  printf "  make %s[target]%s %s[variables]%s\n\n", $BLUE, $RESET, $YELLOW, $RESET;

  help_targets($files);
  help_variables($files);
  help_examples();
  return;
}

=pod
Parse a given comment pattern inside the Makefile targets. The targets, if
not depending on any other targets, should contain a double hash C<#> after
the colon, for example:

  help: ## Print help and exit

=cut
sub help_targets($files) {
    my $pattern = qr/^[a-zA-Z0-9._-]+:.*?##.*$/;
    my @lines;

    for my $file (split ' ', $files) {
        open my $fh, '<', $file or die "Unable to open $file: $!";
        while (my $line = <$fh>) {
            push @lines, $line if $line =~ $pattern;
        }
        close $fh;
    }

    say "Target(s):";
    foreach my $line (sort @lines) {
        my ($target, $description) = $line =~ /^([a-zA-Z0-9._-]+):.*?##\s*(.*)$/;
        printf "  %s%-30s%s%s\n", $BLUE, $target, $RESET, $description;
    }
    say "";
    return;
}

=pod
Parse a given comment pattern above the Makefile variables. The variables you
declare should contain a single comment using a hash (#) on top of them to
describe their purpose, like:

  # Notify the user this is a test
  TEST_MESSAGE = "Spawning a container for testing..."

=cut
sub help_variables($files) {
    my $pattern = qr/^[a-zA-Z0-9_-]+ [:?!+]?=.*$/;
    my @lines;
    my $prev_line = '';

    say "Variable(s):";
    for my $file (split ' ', $files) {
        open my $fh, '<', $file or die "Unable to open $file: $!";
        while (my $line = <$fh>) {
            if ($line =~ $pattern) {
                my ($variable, $default) = $line =~ /^([a-zA-Z0-9_-]+) [:?!+]?= (.*)$/;
                my ($description) = $prev_line =~ /^\s*#\s*(.*)$/;
                $default //= '';  # Ensure $default is defined
                printf "  %s%-30s%s%s %s(default: %s)%s\n", $YELLOW, $variable, $RESET, $description // '', $PURPLE, $default, $RESET;
            }
            $prev_line = $line;
        }
        close $fh;
    }
    say "";
    return;
}

sub help_examples {
    say "Example(s):";
    say "  make dev";
    say "  make fmt";
    return;
}

main_help($ARGV[0]);
__END__

=encoding utf8

=head1 NAME

help.pl - Display help information for Makefile build systems without
external programs other than perl.

=head1 SYNOPSIS

help.pl [FILE]

=head1 OPTIONS

=over 8

=item B<--help>

Print a brief help message and exits.

=back

=head1 DESCRIPTION

C<help.pl> will read the given Makefile and display targets and variables
with their descriptions.

=head1 AUTHOR

Urutaú Limited <softwarelibre@urutau-ltd.org>

=head1 COPYRIGHT AND LICENSE

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
