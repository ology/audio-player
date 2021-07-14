# audio-player
Mojolicious + HTML5 Audio Player App

Light-weight, ultra-simple audio server!

Write-up: [Mojolicious Music Player](https://ology.github.io/2021/06/04/mojolicious-music-player/)

Before running, the perl dependencies are required:

    audio-player $ cpanm --installdeps .

Next symlink your audio source in the public subdirectory:

    audio-player/public $ ln -s /media/you/external_drive/Music/ Audio

Then to run the app:

    audio-player $ morbo audio-player

And browse to http://127.0.0.1:3000/refresh

~

The audio-player2 app is the evolution of the original, but with ratings and streamlined interface/behavior.

It has built-in playback error detection.  If **autoadvance** is on and an error is detected, the app will attempt to load to the next track. And the same goes for **shuffle** mode.  Now if none of the selected tracks (e.g. search results) can be loaded, the app will try each and fail.  If **shuffle** is on and this happens, an infinite loop will occur.  In order to stop this, just click the "Clear Search" button - the bold **x** on the right of the search box in the audio-player2 app.
