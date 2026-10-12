extends CharacterBody2D

@export var damage = 10
var direction
@export var TTL = 5
@export var width = 1

func _ready() -> void:
	rotate(direction.angle() - PI/2)
	$TTL.wait_time = TTL
	$CollisionShape2D.disabled = false
	scale = Vector2(width,width)
	name = "lazer"
	$TTL.start()


func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.
