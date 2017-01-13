use strict;
use warnings;
use Test::More;
use Capture::Tiny qw( capture );

ok 1;

my ($stdout, $stderr ) = capture {
  local $ENV{PATH} = $ENV{PATH};
  eval '# line '. __LINE__ . ' "' . __FILE__ . qq("\n) . q{
    use Alien::patch
  };
};

note "[stdout]\n$stdout" if $stdout;
note "[stderr]\n$stderr" if $stderr;

done_testing;
