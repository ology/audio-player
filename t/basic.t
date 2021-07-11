#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Mojo::File qw(curfile);
use Test::Mojo;

my $script = curfile->dirname->sibling('audio-player');

my $t = Test::Mojo->new($script);

subtest 'autoadvance is not checked' => sub {
  $t->get_ok('/')
    ->status_is(200)
    ->element_exists('input[name=autoadvance]:not(:checked)');
};

subtest 'autoadvance is checked' => sub {
  $t->get_ok('/?autoadvance=1')
    ->status_is(200)
    ->element_exists('input[name=autoadvance]:checked');
};

subtest 'autoadvance is not checked and no track is found' => sub {
  $t->get_ok('/?current=999999999&autoadvance=1')
    ->status_is(200)
    ->element_exists('input[name=autoadvance]:not(:checked)')
    ->text_is('p[id=track]' => ' ');
};

subtest 'no matches and no track are found' => sub {
  $t->get_ok('/?query=aabbccddeeffgg')
    ->status_is(200)
    ->content_like(qr/No matches/)
    ->text_is('p[id=track]' => ' ');
};

subtest 'refresh creates track file' => sub {
  my $filename = $t->app->moniker . '.dat';
  my $now = time;

  # Allow 302 redirect responses
  $t->ua->max_redirects(1);

  $t->get_ok('/refresh')
    ->status_is(200);

  my $mtime = (stat($filename))[9];

  ok -e $filename, 'file created';
  ok $mtime >= $now, 'file is new';
};

done_testing();
