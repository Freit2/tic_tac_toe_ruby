Note: 4x4 board option requires MongoDB.  To install, go here: http://www.mongodb.org/downloads or
if you have homebrew installed, type **brew install mongodb**

To run on stdio
---------------

type **ruby console/lib/tic_tac_toe.rb**

Move positions for 3x3 are:

  0 | 1 | 2
 ---+---+---
  3 | 4 | 5
 ---+---+---
  6 | 7 | 8

Move positions for 4x4 are:

  0 | 1 | 2 | 3
 ---+---+---+---
  4 | 5 | 6 | 7
 ---+---+---+---
  8 | 9 | 10| 11
 ---+---+---+---
  12| 13| 14| 15

To run on Limelight UI
----------------------

type **limelight open limelight/lib**

You must have the following installed:

* JRuby
* Limelight gem
* Limelight binary (*.dmg, *.exe)

See here for more information: http://limelight.8thlight.com/main/download

Once installed, navigate to the cloned repo

To run on WEBrick (WIP)
-----------------------

type **ruby webrick/lib/webrick_ttt.rb**
