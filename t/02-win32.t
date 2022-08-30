use v6;

use Test;
use File::Which;

my @execs = ('calc', 'cmd', 'explorer', 'notepad');

plan @execs.elems * 2;

unless $*DISTRO.is-win {
  skip-rest("Windows-only tests");
  exit;
}

for @execs -> $exec {
  my Str $path = which($exec);
  ok $path.defined, sprintf("Found '%s' at '%s'", $exec, $path);
  ok $path.IO ~~ :e, sprintf("Path '%s' is found", $path);
}
