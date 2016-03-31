
use v6;

use File::Which::Unix;
use File::Which::MacOSX;
use File::Which::Win32;

=begin pod

  File::Which finds the full or relative paths to an executable program on the
  system. This is normally the function of which utility which is typically
  implemented as either a program or a built in shell command. On some unfortunate
  platforms, such as Microsoft Windows it is not provided as part of the core
  operating system.

      use File::Which :whence;

      # All perl executables in PATH
      say which('perl6', :all);

      # First executable in PATH
      say which('perl6');

      # Same as which('perl6')
      say whence('perl6');

=end pod
unit module File::Which;

# Current which platform-specific implementation
my $platform;

sub which(Str $exec, Bool :$all = False) is export {

  unless $platform.defined {
    if $*DISTRO.is-win {
      $platform = File::Which::Win32.new;
    } elsif $*DISTRO.name eq 'macosx' {
      $platform = File::Which::MacOSX.new;
    } else {
      $platform = File::Which::Unix.new;
    }
  }

  return $platform.which($exec, :$all);
}

sub whence(Str $exec, Bool :$all = False) is export(:all, :whence) {
  return which($exec, :$all);
}
