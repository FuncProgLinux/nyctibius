# Nyctibius Griseus

Guix channel with personal software needs.

This channel is **NOT** meant to be consumed by the general public, although,
nothing really stops you from using it. It contains various tools for personal
use and nothing more.

PR's and Issues are ignored on the Read-Only mirror forges, thus, you are on
your own if you install this channel from one of either Codeberg or Mocosoft
GitHub.

## News

> [!IMPORTANT]
> Starting from Dec 1. This channel will merge with the Guix MATE channel, and
> package development will continue from here. This is to focus on a single
> channel and be fast with updates on other tools.
>
> If you still wish to rely on the MATE software available, install this channel
> and replace all your `use-modules` or `#:use-module` from `(guix-mate packages
> something)` to `(nyctibius packages something)`

## Usage

Organization members can refer the original forge's Wiki for the usage snippet.

The same goes for bug reports and package requests.

> I don't care! I still want to use it!

Fine, but don't say I didn't warn you...

1. Clone the repository from whatever mirror you are using. I'll assume your
   checkout will live at `$HOME/src/nyctibius/`
2. Add the subscription snippet to your `/etc/channels.scm` or
   `~/.config/guix/channels.scm`:

```scheme
(channel
    (name 'nyctibius-local)
    (branch "stable")
    (url (string-append "file://"
                        (getenv "HOME") "/src/nyctibius")))
```

## Features

The channel contains the following goodies

### Latest MATE Desktop builds

Where possible I try to keep and maintain MATE Desktop software up to date
and usable in this channel as this is for daily driving. You'll find here
some missing components from GUIX:

- `caja-actions`
- `mate-tweak`
- `brisk-menu`
- `ayatana` indicator libraries
- Linux Mint Icons

### FreeFem Builds

I don't really update much or use this but I hope I can fix the build reproducibility
issues and package this as a `.appimage` soon.

### InfoSec Tools

Some InfoSec tools. Use at your own risk. I do not claim any responsibility for
what you do with them.

## COPYING

The source code available on this channel, except where stated otherwise is
under the terms of the GNU General Public License version 3 or at your option
any other later version.
