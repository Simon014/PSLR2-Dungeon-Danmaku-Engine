extends CharacterBody2D

@export var damage = 10
@export var speed = 100
var direction
@export var TTL = 100
@export var friction = 0.5
@export var acceleration = 2

#specific stuff
@export var Pathstart = 4 #when to activating pathing processing. 0 to start immediately.
@export var PathInfluence = 5 #how much the path should influence the bullet. 1 for full influence. 0 for no influence.

#dynamic stuff
var timeSinceload = 0.0



func _ready() -> void:
	name = "Bullet"
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()
	

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	move_and_slide()


func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.


func _on_pathing_timeout() -> void:
	timeSinceload += 0.05
	if timeSinceload > Pathstart:

		if(position.distance_to(corePlayerVars.position) > position.distance_to(corePartnerVars.position)):
			velocity += position.direction_to(corePartnerVars.position) * PathInfluence * acceleration
		else:
			velocity += position.direction_to(corePlayerVars.position) * PathInfluence * acceleration
	pass # Replace with function body.
