extends CharacterBody2D

func attack():
	var bullet = load("res://Entities/bullets/effect/Bullet.tscn").instantiate()
	bullet.position = position
	bullet.TTL = 5
	bullet.speed = 100
	bullet.acceleration = 22
	bullet.image = "DebugBullet2.png"
	bullet.direction = position.direction_to(get_global_mouse_position())
	bullet.color = Color(0.0, 0.726, 0.361, 1.0)

	get_parent().add_child(bullet)
	pass

func _input(event: InputEvent) -> void:
	velocity = Input.get_vector("left", "right","up","down") * corePlayerVars.speed
	if (Input.is_action_pressed("slowdown")):
		velocity = velocity / 3
	pass
		
func _process(delta: float) -> void:
	move_and_slide()
	corePlayerVars.position = position


func _on_atkcd_timeout() -> void:
	if (Input.is_action_pressed("shoot normal")):
		attack()
	pass # Replace with function body.
