# audio-player
Mojolicious + HTML5 Audio Player App

Light-weight, ultra-simple audio server!

Write-up: [Mojolicious Music Player](https://ology.github.io/2021/06/04/mojolicious-music-player/)

Before running, the perl dependencies are required:

    audio-player $ cpanm --installdeps .

First symlink your audio source in the public subdirectory:

    audio-player/public $ ln -s /media/you/external_drive/Music/ Audio

Then to run the app:

    audio-player $ morbo audio-player

And browse to http://127.0.0.1:3000/refresh

