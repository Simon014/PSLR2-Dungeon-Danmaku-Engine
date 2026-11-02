extends CharacterBody2D

@export var damage = 10
@export var speed = 100
var direction
@export var TTL = 100
@export var friction = 0.5
@export var acceleration = 2

#specific stuff
@export var Pathstart = 4 #when to activating pathing processing. 0 to start immediately.

#dynamic stuff
var timeSinceload = 0.0
@export var color = Color(0.709, 0.0, 0.574, 1.0)
@export var image = "DebugBullet.png"
@export var friendly = false


func _ready() -> void:
	name = "Bullet"
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()
	modulate = color
	$Image.texture = load("res://Entities/bullets/Images/" + image)
	

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	move_and_slide()


func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.


func _on_pathing_timeout() -> void:
	timeSinceload += 0.05
	if timeSinceload > Pathstart:
		if not friendly:
			if(position.distance_to(corePlayerVars.position) > position.distance_to(corePartnerVars.position)):
				velocity += position.direction_to(corePartnerVars.position) * acceleration
			else:
				velocity += position.direction_to(corePlayerVars.position) * acceleration
		else:
			var closestposition = null
			var closestdist = 10000
			for i in get_parent().get_children():
				if i.name.contains("Enemy"):
					if position.distance_to(i.position) < closestdist:
						closestdist = position.distance_to(i.position)
						closestposition = i.position
			if closestposition:
				velocity += position.direction_to(closestposition) * acceleration
			else:
				queue_free() #will only happen if there are NO enemies avaliable.
	pass # Replace with function body.
