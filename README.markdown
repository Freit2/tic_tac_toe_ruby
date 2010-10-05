*Notes:*

* All implementations should run on any Ruby VM with exception to the Limelight version which needs to run on JRuby.

* 4x4 board option requires MongoDB.  To install, go [here](http://www.mongodb.org/downloads) or if you have [homebrew](http://github.com/mxcl/homebrew) installed, type <code>brew install mongodb</code>

To run on console
---------------

type <code>ruby console/lib/tic\_tac\_toe.rb</code> from root directory.

Move positions for 3x3 are 0-8 from top-left to bottom-right.
Move positions for 4x4 are 0-15 from top-left to bottom-right.

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

To run on Limelight UI
----------------------

type <code>limelight open limelight/lib</code> from root directory.

You must have the following installed:

* JRuby 1.5.1 or greater
* Limelight gem
* Limelight binary (*.dmg, *.exe)

Visit [Limelight's website](http://limelight.8thlight.com/main/download) for more information.

To run on WEBrick
-----------------------

type <code>ruby webrick/lib/webrick\_ttt.rb</code> from root directory.

Go to [http://localhost:7546/](http://localhost:7546/)

It supports simultaneous games via cookies.


To run on Rails
-----------------------

Navigate to the rails3 directory, and type </code>rails server</code>

You must have the following installed:

* Ruby 1.8.7 or 1.9.2
* rails gem

Go to [http://localhost:3000/](http://localhost:3000/) unless otherwise noted

It supports simultaneous games via cookies.
