extends CharacterBody2D

@export var damage = 10
@export var speed = 100
var direction
@export var TTL = 5
@export var friction = 0
@export var acceleration = 0



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
	queue_free()
	pass # Replace with function body.
