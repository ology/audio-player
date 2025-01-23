# Mojolicious::Lite + HTML5 Audio Player App

Light-weight, ultra-simple audio server!

Write-up: [Mojolicious Music Player](https://ology.github.io/2021/06/04/mojolicious-music-player/)

This app has logic to fetch cover art from the last.fm API with your API key, declared in the `config.yml` file.

Before running, the perl dependencies are required:

    audio-player $ cpanm --installdeps .

Next symlink your audio source:

    audio-player $ ln -s /media/you/external_drive/Music/ Audio

For windows, as the Administrator do:

    mklink /D C:\Users\you\wherever\audio-player\Audio "X:\My Music"

Then to run the app:

    audio-player $ morbo audio-player5

And first browse to http://127.0.0.1:3000/refresh to index your audio.  Thereafter, http://127.0.0.1:3000/

~

This app does not have traditional form submission. Instead, changing a setting (like shuffle, or the search query) will take effect when the track is advanced.  And this happens either when the Next track button is clicked, or **advance** is on and either the current track ends or a decoding error occurs.

Keystroke interface features are documented on the **Help** page.

This app has built-in playback error detection.  So for example, if **advance** is on and an error is detected, the app will attempt to load to the next track. And the same goes for **shuffle** mode.  Now if none of the selected tracks (e.g. search results) can be loaded, the app will try each and fail.  If **shuffle** is on and this happens, an infinite loop will occur.  In order to stop this, just click the "Clear Search" button - the bold **x** button on the right of the search box or press the `x` key.

![audio-player5](audio-player5.png)
