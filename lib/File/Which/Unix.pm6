
use v6;

unit module File::Which::Unix;

sub which(Str $exec, Bool :$all = False) {
  fail("Exec parameter should be defined") unless $exec;

  my @results;

  return $exec if $exec ~~ /\// && $exec.IO ~~ :f && $exec.IO ~~ :x;

  my @path = flat( $*SPEC.path );

  my @PATHEXT = '';
  for @path.map({ $*SPEC.catfile($_, $exec) }) -> $file  {

    # Ignore possibly -x directories
    next if $file.IO ~~ :d;

    # Executable, normal case
    if $file.IO ~~ :x {
      return $file unless $all;
      @results.push( $file );
    }

  }

  return @results if $all;
  return;
}

=begin pod

=head1 NAME

File::Which::Unix - Linux/Unix which implementation

=end pod