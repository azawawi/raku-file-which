use v6;

use Test;
use File::Which;

plan 1;

is which(''), Any, 'Null-length false result';

is which('non_existent_very_unlinkely_thingy_executable'), Any, 'Positive length false result';
