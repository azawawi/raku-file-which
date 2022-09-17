
use v6;

use File::Which::Unix;
use File::Which::MacOSX;
use File::Which::Win32;

unit module File::Which;

# Current which platform-specific implementation
BEGIN my $platform = $*DISTRO.is-win
  ?? File::Which::Win32.new
  !! $*DISTRO.name.starts-with('macos')
    ?? File::Which::MacOSX.new
    !! File::Which::Unix.new;

sub which(Str $exec, Bool :$all = False) is export {
  return $platform.which($exec, :$all);
}

sub whence(Str $exec, Bool :$all = False) is export(:all, :whence) {
  return which($exec, :$all);
}

=begin pod

=head1 NAME

File::Which - Cross platform Raku executable path finder (aka which on UNIX)

=head1 SYNOPSIS

  use File::Which :whence;

  # All raku executables in PATH
  say which('raku', :all);

  # First executable in PATH
  say which('raku');

  # Same as which('raku')
  say whence('raku');

=head1 DESCRIPTION

This is a Raku Object-oriented port of L<File::Which (CPAN)|https://metacpan.org/pod/File::Which>.

File::Which finds the full or relative paths to an executable program on the
system. This is normally the function of which utility which is typically
implemented as either a program or a built in shell command. On some unfortunate
platforms, such as Microsoft Windows it is not provided as part of the core
operating system.

This module provides a consistent API to this functionality regardless of the
underlying platform.

=head1 AUTHOR

Ahmad M. Zawawi <ahmad.zawawi@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Ahmad M. Zawawi

This library is free software; you can redistribute it and/or modify it under
the MIT License

=end pod
