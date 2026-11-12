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

@export var color = Color(0.709, 0.0, 0.574, 1.0)
@export var image = "DebugBullet.png"
@export var friendly = false


#can be either poison, slow, defdown, atkdown
func _ready() -> void:
	name = "Effect"
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()
	$CollisionShape2D.shape.radius = effectRadius
	scales = float(effectRadius)
	$Image.scale.x = scales/100
	$Image.scale.y = scales/100
	modulate = color
	$Image.texture = load(image)
	
func _process(delta: float) -> void:
	velocity += direction * acceleration
	velocity -= velocity * friction
	move_and_slide()

func _on_ttl_timeout() -> void:
	queue_free()
	pass # Replace with function body.
