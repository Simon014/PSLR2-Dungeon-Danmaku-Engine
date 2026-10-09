extends Node

#player variables. to be saved and loaded from a save file, and updated dynamically. 
# all player variables at that moment is written to and saved here.

var Health = 100
var SP = 100
var SPmax = SP * 1.5
var speed = 400
var position
#combat stats
var attack = 1
var defence = 1
var attackspeed = 100
#effect data
var PoisonRemaining = 0
var SlowRemaining = 0
var DefLowerRemaining = 0
var AtkLowerRemaining = 0
