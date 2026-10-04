extends CharacterBody2D

var damage = 10
var speed = 100
var direction
var TTL = 5
var friction = 0
var acceleration = 0



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
