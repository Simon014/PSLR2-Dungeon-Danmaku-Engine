extends CharacterBody2D

@export var speed = 100
@export var TTL = 5
@export var friction = 0
@export var acceleration = 0
@export var effectRadius = 30.0
@export var effectDuration = 40
@export var effect = "poison"
#dynamic variables
var direction
var scales


#can be either poison, slow, defdown, atkdown
func _ready() -> void:
	name = "Effect"
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()
	$CollisionShape2D.shape.radius = effectRadius
	scales = float(effectRadius)
	$DebugBullet.scale.x = scales/100
	$DebugBullet.scale.y = scales/100
	
func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	move_and_slide()

func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.
