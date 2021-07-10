#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Mojo::File qw(curfile);
use Test::Mojo;

my $script = curfile->dirname->sibling('audio-player');

my $t = Test::Mojo->new($script);

# Allow 302 redirect responses
$t->ua->max_redirects(1);

# autoadvance is not checked
$t->get_ok('/')
  ->status_is(200)
  ->element_exists('input[name=autoadvance]:not(:checked)');

# autoadvance is checked
$t->get_ok('/?autoadvance=1')
  ->status_is(200)
  ->element_exists('input[name=autoadvance]:checked');

# autoadvance is not checked and no track is found
$t->get_ok('/?current=999999999&autoadvance=1')
  ->status_is(200)
  ->element_exists('input[name=autoadvance]:not(:checked)')
  ->text_is('p[id=track]' => ' ');

# no matches and no track are found
$t->get_ok('/?query=aabbccddeeffgg')
  ->status_is(200)
  ->content_like(qr/No matches/)
  ->text_is('p[id=track]' => ' ');

# refresh creates track file
$t->get_ok('/refresh')
  ->status_is(200);

ok -e $t->app->moniker . '.dat', 'track file created';

done_testing();
