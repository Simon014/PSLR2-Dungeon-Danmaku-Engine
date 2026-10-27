extends Node

#player variables. to be saved and loaded from a save file, and updated dynamically. 
# all player variables at that moment is written to and saved here.

var Health = 100
var MaxHealth = 100
var SP = 100
var SPmax = SP * 1.5
var speed = 200
var position = Vector2.ZERO
var followdist = 400

#combat stats
var attack = 1
var defence = 1 #out of 100, where 100 is full damage protection. 25 for 25% damage reduction etc
var attackspeed = 300
#effect data
var PoisonRemaining = 0
var SlowRemaining = 0
var DefLowerRemaining = 0
var AtkLowerRemaining = 0
