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

* Make it more obvious which card was player in some of the card actions.
* Bug: Check if player dies from a deflector attack before grabbing them!
* Option: Players joining mid-game should have an averaged HP instead of 10.
* Achievements:
 * Bee Bonus: kill someone with bees
 * Close Call Bonus: 1 health left
 * Deflector Bonus: use deflector multiple times in the same game
 * Heal Bonus: heal over 12 health points (+1 damage for every 2 health)
 * "Where's the fight?" Bonus: miss 7 turns or more
