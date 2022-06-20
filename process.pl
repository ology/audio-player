#!/usr/bin/env perl
use strict;
use warnings;

use IO::Prompt qw(prompt);
use Mojo::File;
use Storable qw(retrieve store);

use constant TRACKS => 'audio-player4.dat'; # The tracks file

my $audio = {}; # Bucket for all tracks

# Load the track list or flash an error
if (-e TRACKS) {
  $audio = retrieve(TRACKS);
}
else {
  die "Cannot read track list file!\n";
}

my $i = 0;

TRACK: for my $n (sort { $a <=> $b } keys %$audio) {
  my $track = Mojo::File->new("public$audio->{$n}{track}");
  next unless -e $track;
  $i++;
  my $rating = $audio->{$n}{rating};
  if ($rating < 0) {
    print '-' x 70, "\n";
    print "$i. REENCODE: $n $track\n";
    my $response = prompt 'Enter=skip q=quit r=reencode: ';
    if ($response eq 'q') {
      last TRACK;
    }
    elsif ($response eq 'r') {
      my $outfile = reencode($track);
      unless ($outfile && -e $outfile) {
        warn "\tERROR: Can't reencode track\n";
        next TRACK;
      }
      $outfile =~ s/\/media\/gene\/New Volume//;
      $audio->{$n}{track} = $outfile;
      print "\tSet reencoded track to $outfile\n";
      $track->remove;
      print "\tRemoved original track\n";
    }
  }
  elsif ($rating && $rating > 0 && $rating < 3) {
    print "$i. DELETE: $n $track\n";
    $track->remove or warn "Can't unlink $track: $!\n";
    delete $audio->{$n};
    print "\tRemoved track\n";
  }
#  elsif ($rating && $rating >= 3) {
#    print "$i. KEEP: $n $track\n";
#  }
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
