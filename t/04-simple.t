use v6;

use Test;
use File::Which;

plan 1;

is which(''), Any, 'Null-length false result';
