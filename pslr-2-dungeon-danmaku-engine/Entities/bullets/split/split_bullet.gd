extends CharacterBody2D

var damage
var speed
var direction
var TTL = 2
var friction = 0.5
var split = 10



func _ready() -> void:
	velocity = direction * speed 
	$TTL.wait_time = TTL
	$TTL.start()

func _process(delta: float) -> void:
	velocity -= velocity * friction * 0.01
	move_and_slide()


func _on_ttl_timeout() -> void:
	var anglechange = 360 / split
	var currentangle = 0
	print(anglechange)
	for i in range(split):
		var bullet = load("res://Entities/bullets/normal/Bullet.tscn").instantiate()
		bullet.speed = speed
		bullet.TTL = 2
		bullet.direction = Vector2.from_angle(deg_to_rad(currentangle))
		bullet.damage = damage
		bullet.friction = 1
		bullet.position = position
		get_parent().add_child(bullet)
		currentangle += anglechange
	queue_free()
	pass # Replace with function body.
