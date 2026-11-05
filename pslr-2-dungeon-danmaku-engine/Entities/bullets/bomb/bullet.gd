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
#visual config
@export var color = Color(0.709, 0.0, 0.574, 1.0)
@export var image = "DebugBullet2.png"
@export var explosionImage = ""
#changed variables
var scales
@export var friendly = false



func _ready() -> void:
	name = "Bomb"
	velocity = direction * speed 
	scales = float(explosionRadius)
	$TTL.wait_time = TTL
	$TTL.start()
	$explode.scale.x = scales/100
	$explode.scale.y = scales/100
	modulate = color
	$Image.texture = load(image)
	$explode.texture = load(explosionImage)

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	velocity += direction * acceleration
	move_and_slide()


func _on_ttl_timeout() -> void:
	$explode.visible = true
	$Image.visible = false
	$AnimationPlayer.play("explode")
	$CollisionShape2D.shape.radius = explosionRadius
	pass # Replace with function body.

func iexploded():
	return $TTL.is_stopped()
func _on_animation_player_current_animation_changed(name: StringName) -> void:
	if name == "":
		queue_free()
	pass # Replace with function body.
