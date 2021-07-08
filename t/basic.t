#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Mojo::File qw(curfile);
use Test::Mojo;

my $script = curfile->dirname->sibling('audio-player');

my $t = Test::Mojo->new($script);

$t->get_ok('/')
  ->status_is(200)
  ->element_exists('input[name=autoadvance]:not(:checked)');

$t->get_ok('/?autoadvance=1')
  ->status_is(200)
  ->element_exists('input[name=autoadvance]:checked');

done_testing();
