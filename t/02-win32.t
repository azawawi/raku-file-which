use v6;

use Test;
use lib 'lib';
use File::Which;

my @execs = ('calc', 'cmd', 'explorer', 'iexplore');

plan @execs.elems;

unless $*DISTRO.is-win {
  skip-rest("Windows-only tests");
  exit;
}

for @execs -> $exec {
  my Str $path = which($exec);
  diag sprintf("which('%s') = '%s'", $exec, $path.defined ?? $path !! "" );
  ok $path.defined, sprintf("Found path for %s", $exec);
}
