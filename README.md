# Mojolicious + HTML5 Audio Player App

Light-weight, ultra-simple audio server!

Write-up: [Mojolicious Music Player](https://ology.github.io/2021/06/04/mojolicious-music-player/)

Before running, the perl dependencies are required:

    audio-player $ cpanm --installdeps .

Next symlink your audio source in the public subdirectory:

    audio-player/public $ ln -s /media/you/external_drive/Music/ Audio

For windows, as the Administrator do:

    mklink /D C:\Users\you\wherever\audio-player\public\Audio "C:\Users\you\external drive\Music"

Then to run the app:

    audio-player $ morbo audio-player

And browse to http://127.0.0.1:3000/refresh

~

The audio-player2 app is the evolution of the original, but with ratings and streamlined interface/behavior.

This app does not have traditional form submission. Instead, changing a setting (like shuffle, or the search query) will take effect when the track is advanced.  And this happens either when the Next track button is clicked, or **advance** is on and either the current track ends or a decoding error occurs.

Hidden interface features:  Clicking the word "Rating" will take you to the /stats breakdown, if you have rated tracks.  Pressing the `p` key will either pause or play the current track.  Pressing the `0` through `5` keys will rate the current track at that level.  Pressing the `f` key will relocate to the first track (if not shuffling).  This is the same as clicking the "First" button.  Pressing the `n` key is the same as clicking the "Next" button.  The `h` key focuses on the history list, the `r` key focuses on the rate filter list, and the `s` key focuses on the search input.  When not focused on the search input, the `x` key will clear the search.

This app has built-in playback error detection.  So for example, if **advance** is on and an error is detected, the app will attempt to load to the next track. And the same goes for **shuffle** mode.  Now if none of the selected tracks (e.g. search results) can be loaded, the app will try each and fail.  If **shuffle** is on and this happens, an infinite loop will occur.  In order to stop this, just click the "Clear Search" button - the bold **x** button on the right of the search box or press the `x` key.

