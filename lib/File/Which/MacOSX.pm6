
use v6;

unit module File::Which::MacOSX;

sub which(Str $exec, Bool :$all = False) {
  fail("Exec parameter should be defined") unless $exec;

  my @results;

  # check for aliases first
  my @aliases = %*ENV<Aliases>:exists ?? %*ENV<Aliases>.split( ',' ) !! ();
  for @aliases -> $alias {
    # This has not been tested!!
    # PPT which says MPW-Perl cannot resolve `Alias $alias`,
    # let's just hope it's fixed
    if $alias.lc eq $exec.lc {
      chomp(my $file = qx<Alias $alias>);
      last unless $file;  # if it failed, just go on the normal way
      return $file unless $all;
      @results.push( $file );
      last;
    }
  }

  my @path = flat( $*SPEC.path );

  for  @path.map({ $*SPEC.catfile($_, $exec) }) -> $file  {

      # Ignore possibly -x directories
      next if $file.IO ~~ :d;

      if
        # Executable, normal case
        $file.IO ~~ :x
        # MacOS doesn't mark as executable so we check -e
        || $file.IO ~~ :e
      {
        return $file unless $all;
        @results.push( $file );
      }
    }
  }

=begin pod

=head1 NAME

File::Which::MacOSX - MacOSX which implementation

=end pod