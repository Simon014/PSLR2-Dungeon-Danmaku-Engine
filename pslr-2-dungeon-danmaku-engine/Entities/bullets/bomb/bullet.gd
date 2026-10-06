extends CharacterBody2D

@export var damage = 10
@export var speed = 100
var direction
@export var TTL = 2
@export var friction = 0
@export var acceleration = 0
# special configurations
@export var explosionRadius = 35
@export var explosionDamage = 0.5

#changed variables
var scales
var currentarea



func _ready() -> void:
	name = "Bomb"
	velocity = direction * speed 
	scales = float(explosionRadius)
	$TTL.wait_time = TTL
	$TTL.start()
	$explode.scale.x = scales/100
	$explode.scale.y = scales/100
	currentarea = $CollisionShape2D.shape.radius
	print(currentarea)

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	velocity += direction * acceleration
	move_and_slide()


func _on_ttl_timeout() -> void:
	$explode.visible = true
	$Image.visible = false
	$AnimationPlayer.play("explode")
	$CollisionShape2D.shape.radius = explosionRadius
	currentarea = $CollisionShape2D.shape.radius
	pass # Replace with function body.

func _on_animation_player_current_animation_changed(name: StringName) -> void:
	if name == "":
		queue_free()
	pass # Replace with function body.
