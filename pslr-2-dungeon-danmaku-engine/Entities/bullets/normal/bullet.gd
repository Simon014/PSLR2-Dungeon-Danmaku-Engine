extends CharacterBody2D

var damage
var speed
var direction
var TTL = 5
var friction = 0.5



func _ready() -> void:
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	move_and_slide()


func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.
