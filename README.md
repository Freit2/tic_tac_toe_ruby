Note: 4x4 board option requires MongoDB.  To install, go here: http://www.mongodb.org/downloads or
if you have homebrew installed, type **brew install mongodb**

To run on stdio
---------------

type **ruby console/lib/tic_tac_toe.rb**

Move positions for 3x3 are 0-8 from top-left to bottom-right:

<pre>
 0 | 1 | 2
---+---+---
 3 | 4 | 5
---+---+---
 6 | 7 | 8

 0 | 1 | 2 | 3
---+---+---+---
 4 | 5 | 6 | 7
---+---+---+---
 8 | 9 | 10| 11
---+---+---+---
 12| 13| 14| 15
</pre>

Move positions for 4x4 are 0-15 from top-left to bottom-right

To run on Limelight UI
----------------------

type **limelight open limelight/lib**

You must have the following installed:

* JRuby
* Limelight gem
* Limelight binary (*.dmg, *.exe)

See here for more information: http://limelight.8thlight.com/main/download

Once installed, navigate to the cloned repo

To run on WEBrick
-----------------------

type **ruby webrick/lib/webrick_ttt.rb**

Go to http://localhost:7546/

This should be able to run any Ruby VM.  It supports simultaneous game play.


To run on Rails (WIP)
-----------------------

Navigate to the rails3 dir, and type **rails server**
