#!/usr/bin/env perl
use strict;
use warnings;

use Mojo::File;
use Storable qw(retrieve store);

use constant TRACKS => 'audio-player2.dat'; # The tracks file

my $to_reencode = shift || die "Usage: perl $0 /some/track.m4a\n";

my $audio = {}; # Bucket for all tracks

# Load the track list or flash an error
if (-e TRACKS) {
  $audio = retrieve(TRACKS);
}
else {
  die "Cannot read track list file!\n";
}

for my $n (keys %$audio) {
  my $track = Mojo::File->new("public$audio->{$n}{track}");
  next unless -e $track;
  if ($to_reencode eq $track) {
    print "REENCODE: $track\n";
    my $outfile = reencode($track);
    unless ($outfile && -e $outfile) {
      warn "\tERROR: Can't set reencoded track!\n";
      last;
    }
    $outfile =~ s/\/media\/gene\/New Volume//;
    $audio->{$n}{track} = $outfile;
    print "\tSet reencoded track to $outfile\n";
    $track->remove;
    print "\tRemoved original track\n";
    last;
  }
}

# Save the tracks to disk
store $audio, TRACKS;

sub reencode {
  my $track = shift;
  my $path = $track->realpath;
  (my $outfile = $path) =~ s/^(.+?)\.\w+$/$1/;
  $outfile .= '-' . time() . '.mp3';
  my @cmd = (qw(ffmpeg -i), $path, qw(-c:v copy -c:a libmp3lame -q:a 4), $outfile);
#  print "@cmd\n";
  if (system(@cmd) == 0) {
    print "\t$track re-encoded to $outfile\n";
    return $outfile;
  }
  else {
    print "\t$track not re-encoded: $?\n";
    return undef;
  }
}
