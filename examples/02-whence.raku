#!/usr/bin/env raku

use v6;
use File::Which :whence;

# All perl executables in PATH
say whence('raku', :all);

# First executable in PATH
say whence('raku');
