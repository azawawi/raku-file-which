#!/usr/bin/env raku

use v6;
use File::Which;

# All perl executables in PATH
say which('raku', :all);

say which('zzzaaa123', :all);

# First executable in PATH
say which('raku');
