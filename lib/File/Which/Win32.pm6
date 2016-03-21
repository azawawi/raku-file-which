
use v6;

unit class File::Which::Win32;

method which(Str $exec, Bool :$all = False) {
  fail("Exec parameter should be defined") unless $exec;

  my @PATHEXT = '';
  # WinNT. PATHEXT might be set on Cygwin, but not used.
  if ( %*ENV<PATHEXT>.defined ) {
    @PATHEXT = flat( %*ENV<PATHEXT>.split(';') );
  } else {
    # Win9X or other: doesn't have PATHEXT, so needs hardcoded.
    @PATHEXT.push( <.com .exe .bat> );
  }

  my @results;

  my @path = flat( $*SPEC.path );

  for  @path.map({ $*SPEC.catfile($_, $exec) }) -> $base  {
    for @PATHEXT -> $ext {
      my $file = $base ~ $ext;

      # Ignore possibly -x directories
      next if $file.IO ~~ :d;

      # Windows systems don't pass -x on
      # non-exe/bat/com files. so we check -e.
      # However, we don't want to pass -e on files
      # that aren't in PATHEXT, like README.
      if @PATHEXT[1..@PATHEXT.elems - 1].grep({ $file.match(/ $_ $ /, :i) })
         && $file.IO ~~ :e
      {
        return $file unless $all;
        @results.push( $file );
      }
    }
  }

  return @results if $all;
  return;
}

=begin pod

=head1 NAME

File::Which::Win32 - Win32 which implementation

=end pod