extends CharacterBody2D

@export var damage = 0
@export var speed = 0
var direction
@export var TTL = 5
@export var friction = 0
@export var acceleration = 0

#special configurations for this bullet
@export var split = 4
var splitinto
"""
TODO : ONCE ALL OTHER BULLETS ARE DONE, INCLUDING LAZERS, GO BACK AND MODIFY
THIS TO TAKE AN ARRAY, basically a "make this bullet, with this configuration"
"""
#if the split bullet is unset, then it will summon a default normal bullet.



func _ready() -> void:
	name = "Bullet"
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01 
	velocity += direction * acceleration
	move_and_slide()


func _on_ttl_timeout() -> void:
	var anglechange = 360 / split
	var currentangle = 0
	if (splitinto):
		for i in range(split):
			var splitter = splitinto.duplicate()
			splitter.direction = Vector2.from_angle(deg_to_rad(currentangle))
			splitter.position = position
			get_parent().add_child(splitter)
			currentangle += anglechange
		queue_free()
	else:
		for i in range(split):
			var bullet = load("res://Entities/bullets/normal/Bullet.tscn").instantiate()
			bullet.direction = Vector2.from_angle(deg_to_rad(currentangle))
			bullet.position = position
			get_parent().add_child(bullet)
			currentangle += anglechange
		queue_free()
		pass
	pass # Replace with function body.
