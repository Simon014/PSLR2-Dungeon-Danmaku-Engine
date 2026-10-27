extends CharacterBody2D

@export var damage = 100
var direction
@export var TTL = 5
@export var width = 0.25
@export var warningtime = 1
@export var color = Color(255,255,255,0.2)

func _ready() -> void:
	rotate(direction.angle() - PI/2)
	$TTL.wait_time = TTL
	$CollisionShape2D.disabled = false
	scale = Vector2(width,1)
	name = "lazer"
	$ColorRect.color = color
	$ColorRect.color.a = 0.2
	$TTL.start()
	$TTLWARN.wait_time = warningtime
	$TTLWARN.start()
	


func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.


func _on_ttlwarn_timeout() -> void:
	$ColorRect.color = color
	$ColorRect.color.a = 1
	pass # Replace with function body.
	
func isactive():
	return $TTLWARN.time_left == 0
