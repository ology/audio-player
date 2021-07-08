#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Mojo::File qw(curfile);
use Test::Mojo;

my $script = curfile->dirname->sibling('audio-player');

my $t = Test::Mojo->new($script);

$t->get_ok('/')
  ->status_is(200);

$t->get_ok('/?current=-1')
  ->status_is(200);

is $t->tx->req->url->query->{string}, 'current=-1', 'query string';

done_testing();
