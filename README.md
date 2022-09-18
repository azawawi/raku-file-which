# File::Which

[![Build
status](https://ci.appveyor.com/api/projects/status/github/azawawi/raku-file-which?svg=true)](https://ci.appveyor.com/project/azawawi/raku-file-which/branch/master)

This is a Raku Object-oriented port of [File::Which (CPAN)](
https://metacpan.org/pod/File::Which).

File::Which finds the full or relative paths to an executable program on the
system. This is normally the function of which utility which is typically
implemented as either a program or a built in shell command. On some unfortunate
platforms, such as Microsoft Windows it is not provided as part of the core
operating system.

This module provides a consistent API to this functionality regardless of the
underlying platform.

```Raku
use File::Which :whence;

# All raku executables in PATH
say which('raku', :all);

# First executable in PATH
say which('raku');

# Same as which('raku')
say whence('raku');
```

## Installation

To install it using zef (a module management tool bundled with Rakudo Star):

```
$ zef install File::Which
```

## Testing

- To run tests:
```
$ prove --ext .rakutest -ve "raku -I."
```

- To run all tests including author tests (Please make sure
[Test::Meta](https://github.com/jonathanstowe/Test-META) is installed):
```
$ zef install Test::META
$ TEST_AUTHOR=1 prove --ext .rakutest -ve "raku -I."
```

## Author

Raku port:
- Ahmad M. Zawawi, azawawi on #raku, https://github.com/azawawi/

A bit of tests:
- Altai-man, sena_kun on libera, https://github.com/Altai-man/

Perl 5 version:
- Author: Per Einar Ellefsen <pereinar@cpan.org>
- Maintainers:
  - Adam Kennedy <adamk@cpan.org>
  - Graham Ollis <plicease@cpan.org>

## License

MIT License
