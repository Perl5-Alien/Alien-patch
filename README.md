# Alien::patch [![Build Status](https://secure.travis-ci.org/Perl5-Alien/Alien-patch.png)](http://travis-ci.org/Perl5-Alien/Alien-patch)

Find or build patch

# SYNOPSIS

    use Alien::patch ();
    use Env qw( @PATH );
    
    unshift @PATH, Alien::patch->bin_dir;
    my $patch = Alien::patch->exe;
    system "$patch -p1 < foo.patch";

Or with [Alien::Build::ModuleBuild](https://metacpan.org/pod/Alien::Build::ModuleBuild):

    use Alien::Base::ModuleBuild;
    Alien::Base::ModuleBuild->new(
      ...
      alien_bin_requires => {
        'Alien::patch' => '0.08',
      },
      alien_build_commands => {
        '%{patch} -p1 < foo.patch',
      },
      ...
    )->create_build_script;

# DESCRIPTION

Many environments provide the patch command, but a few do not.
Using this module in your `Build.PL` (or elsewhere) you can
make sure that patch will be available.  If the system provides
it, then great, this module is a no-op.  If it does not, then
it will download and install it into a private location so that
it can be added to the `PATH` when this module is used.

This class is a subclass of [Alien::Base](https://metacpan.org/pod/Alien::Base), so all of the methods documented there
should work with this class.

# METHODS

## exe

    my $exe = Alien::patch->exe;

Returns the command to run patch on your system.  For now it simply
adds the `--binary` option on Windows (`MSWin32` but not `cygwin`)
which is usually what you want.

# HELPERS

## patch

    %{patch}

When used with [Alien::Base::ModuleBuild](https://metacpan.org/pod/Alien::Base::ModuleBuild) in a `alien_build_commands` or `alien_install_commands`,
this helper will be replaced by either `patch` (Unix and cygwin) or `patch --binary` (MSWin32).

# CAVEATS

This version of [Alien::patch](https://metacpan.org/pod/Alien::patch) adds patch to your path, if it isn't
already there when you use it, like this:

    use Alien::patch;  # deprecated, issues a warning

This was a design mistake, and now **deprecated**.  When [Alien::patch](https://metacpan.org/pod/Alien::patch) was
originally written, it was one of the first Alien tool style modules on
CPAN.  As such, the author and the [Alien::Base](https://metacpan.org/pod/Alien::Base) team hadn't yet come up
with the best practices for this sort of module.  The author, and the
[Alien::Base](https://metacpan.org/pod/Alien::Base) team feel that for consistency and for readability it is
better use [Alien::patch](https://metacpan.org/pod/Alien::patch) without the automatic import:

    use Alien::patch ();

and explicitly modify the `PATH` yourself (examples are above in the
synopsis).  The old style will issue a warning.  The old behavior will be
removed, but not before 31 January 2018.

# AUTHOR

Author: Graham Ollis <plicease@cpan.org>

Contributors:

Zakariyya Mughal

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
