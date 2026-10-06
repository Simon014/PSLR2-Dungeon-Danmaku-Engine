extends CharacterBody2D

func attack():

	var splitter = load("res://Entities/bullets/bomb/Bullet.tscn").instantiate()
	splitter.explosionRadius = 3000
	splitter.explosionDamage = 0.7
	splitter.TTL = 3
	splitter.speed = corePlayerVars.attackspeed
	splitter.damage = corePlayerVars.attack 
	splitter.friction = 1

	splitter.direction = position.direction_to(get_global_mouse_position())
	splitter.position = position
	get_parent().add_child(splitter)
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
