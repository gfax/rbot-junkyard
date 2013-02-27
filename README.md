junkyard-rbot
==========

Junkyard card game for rbot.

* junkyard.rb - public release of Junkyard
* brawl.rb - original version of Junkyard, using #gfax's custom deck

##Installation
Drop `junkyard.rb` in your rbot's plugin folder and run `!rescan` to reload your plugins. Type `!help junkyard` (or simply `!help junk`) for more information. Any available config options can be found using `!config search junkyard`.

##Gameplay
http://wiki.gfax.ch/Junkyard

##TODO
###Bugs
* Sometimes attacks don't register when passing (on grabs).
* Check if player dies from a deflector attack before grabbing them!
###Features
* ti command to see amount of time played
* Achievements:
 * Heal Bonus: healing over 12(?) health points?
 * Bee Bonus: kill someone with bees
 * Deflector Bonus: use deflector multiple times in the same game
