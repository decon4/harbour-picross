# Picross for Sailfish OS
## Idea of Picross puzzles
Solve the puzzles to find the hidden pictures in the grid based on numeric clues. For every clue, there is a block of adjacent cells of that size in that row or column. The only unknown is the amount of empty space between the blocks - maybe before the first and after the last block, too - and that is the logic behind Picross.

Levels are sorted by difficulty, and you have to complete one difficulty to unlock the next one. At the moment, there are 103 levels spread across six difficulties.

## About this fork
The original [harbour-picross](https://github.com/Baspar/harbour-picross) was developed by @Baspar, along with most of the current levels (99 out of 103, if I am not mistaken).  As the last version released didn't work anymore (without applying [https://github.com/Baspar/harbour-picross/pull/4/commits/805254ddab46750d1f5b15ed5a046cbcaf899478](a patch)), I decided to fork it, fix it, tweak it and release it.

## How to transfer progress from the original Picross?
### Background
First of all, in order for me to continue Baspars work, I had to fork the application and release it using my own Jolla account. This means that I cannot directly update the original application, but instead I had to submit "a completely new" application with a different name. Because Sailfish keeps data of every application pretty much separated from each other, Picross 2 can't access data of Picross directly.

All this unfortunately leads into that you lose all progress when installing Picross 2 on top of the original Picross. Luckily, that can be fixed by hand! All we have to do is to rename two folders (three, if you have started Picross 2 even once) and we're done!

Simply put: rename
```
~/.local/share/harbour-picross/harbour-picross/
```
to
```
~/.local/share/harbour-picross2/harbour-picross2/
```
Note that `harbour-picross` is listed twice in the path, and both directories must be renamed.

### Instructions
There is an easy way to do this using File Browser application, which is available in Jolla Store. The advantage of this method is that it does not include using terminal or developer mode.

* Make sure both Picross and Picross 2 are closed
* Start File Browser
* Go to Settings in pulley menu
* Enable "Show hidden files", then go back
* Enter folder called `.local`
* Enter folder called `share`
* If you have started Picross 2 at least once, folder  has to renamed
  * Long press `harbour-picross2` and select Properties
  * From the pulley menu select Rename
  * Enter `harbour-picross2.bak` and accept the dialog (Rename)
  * Swipe left once so that you are in `share` folder
* Rename the original Picross folder, and its subfolder too
  * Long press `harbour-picross` and select Properties
  * From the pulley menu select Rename
  * Enter `harbour-picross2` and accept the dialog (Rename)
  * Swipe left once so that you are in `share` folder
  * Enter `harbour-picross2` (the one you just renamed)
  * Long press `harbour-picross` and select Properties
  * From the pulley menu select Rename
  * Enter `harbour-picross2` and accept the dialog (Rename)

Now you should have your progress transfered into Picross 2!

# I would like to contribute, how can do it?
If you find bugs, want to translate the strings or submit new levels, you can make a pull request. Or, if that seems too tedious, you can just create a new issue and post it there.

Happy solving!
