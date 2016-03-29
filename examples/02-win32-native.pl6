use v6;

die "This should be run only on windows" unless $*DISTRO.is-win;

use lib 'lib';
use NativeCall;
use File::Which;

constant LIB      = 'shlwapi';

constant ASSOCF_OPEN_BYEXENAME = 0x2;
constant ASSOCSTR_EXECUTABLE   = 0x2;
constant MAX_PATH              = 260;
constant S_OK                  = 0;

#
#  HRESULT AssocQueryString(
#    _In_      ASSOCF   flags,
#    _In_      ASSOCSTR str,
#    _In_      LPCTSTR  pszAssoc,
#    _In_opt_  LPCTSTR  pszExtra,
#    _Out_opt_ LPTSTR   pszOut,
#    _Inout_   DWORD    *pcchOut
#  );
#
sub AssocQueryStringA(uint32 $flags, uint32 $str, Str $assoc, uint32 $extra,
  CArray[uint16] $path, CArray[uint32] $out) returns uint32 is native(LIB) { * };

sub find(Str $exec) returns Str {
  my $path = CArray[uint8].new;
  $path[$_] = 0 for 0..MAX_PATH - 1;

  my $size = CArray[uint32].new;
  $size[0] = MAX_PATH;
  my $hresult = AssocQueryStringA(ASSOCF_OPEN_BYEXENAME, ASSOCSTR_EXECUTABLE,
    $exec, 0, $path, $size);

  return unless $hresult == S_OK;

  my $exe-path = '';
  for 0..$size[0] - 1 {
    $exe-path ~= chr($path[$_]);
  }
  return $exe-path;
}

my @execs = (
  'firefox',
  'cmd',
  'iexplore'
);

for @execs -> $exec {
  my Str $path = find($exec);
  my Str $which-path = which($exec);
  say sprintf("which('%s') = %s", $exec, $which-path.defined ?? $which-path !! "Not found" );
  say sprintf("find('%s')  = %s", $exec, $path.defined ?? $path !! "Not found");
}
