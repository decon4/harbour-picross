# Picross for Sailfish OS
## Idea of Picross puzzles
Solve the puzzles to find the hidden pictures in the grid based on numeric clues. For every clue, there is a block of adjacent cells of that size in that row or column. The only unknown is the amount of empty space between the blocks - maybe before the first and after the last block, too - and that is the logic behind Picross.

Levels are sorted by difficulty, and you have to complete one difficulty to unlock the next one. At the moment, there are 103 levels spread across six difficulties.

## About this fork
The original [harbour-picross](https://github.com/Baspar/harbour-picross) was developed by @Baspar, along with most of the current levels.  As the last version released didn't work anymore (without applying [https://github.com/Baspar/harbour-picross/pull/4/commits/805254ddab46750d1f5b15ed5a046cbcaf899478](a patch)), I decided to fork it, fix it, tweak it and release it.

## How to transfer Picross progress?
### Background
Because Jolla Store, naturally, does not allow two applications have a same name, I had to use a different name. Hence, Sailfish OS stores the data in different directory. Luckily this is the only thing that needs to be done: rename `harbour-picross` data storage folder structure to match `harbour-picross2`. That is, rename
```
~/.local/share/harbour-picross/harbour-picross/
```
to
```
~/.local/share/harbour-picross2/harbour-picross2/
```
Note that `harbour-picross` is listed twice in the path, and both directories must be renamed.

### Step-by-step
At the moment, this has to be done in terminal. Enable Developer mode in Settings, wait for the installation to succeed, and start the terminal.

Please be careful whenever you use command line! Wrongly entered commands may lead to data loss! Ask for help if you are not confident!

First, let's enter the application user data directory:
```
[nemo@jolla ~]$ cd .local/share/
[nemo@jolla share]
```
If you have opened Picross 2, you have to move the new data out of the way:
```
[nemo@jolla share]$ mv harbour-picross2 harbour-picross2.bak
```
Now we can move the data from Picross to Picross 2! Due to the way Sailfish OS stores application data, this requires total of three commands:
```
[nemo@jolla share]$ mv harbour-picross harbour-picross2
[nemo@jolla share]$ cd harbour-picross2
[nemo@jolla harbour-picross2]$ mv harbour-picross harbour-picross2
```
If someone finds out a way to rename folders in QML-only Sailfish application, please let me know.

# Great! How can I help?
If you find bugs, want to translate the strings or submit new levels, you can make a pull request! Or, if that seems too tedious, you can just create a new issue and post it there.

Happy solving!
