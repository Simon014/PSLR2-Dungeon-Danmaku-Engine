extends CharacterBody2D

@export var damage = 10
@export var speed = 100
var direction
@export var TTL = 5
@export var friction = 0
@export var acceleration = 0

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
	velocity += direction * acceleration
	move_and_slide()


func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.
