extends CharacterBody2D

func attack():
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.speed = corePlayerVars.attackspeed
	bullet.damage = corePlayerVars.attack
	bullet.split = 10
	bullet.acceleration = 0
	bullet.TTL = 4
	var splitter = load("res://Entities/bullets/bomb/Bullet.tscn").instantiate()
	splitter.speed = corePlayerVars.attackspeed
	splitter.damage = corePlayerVars.attack
	splitter.explosionRadius = 50
	splitter.TTL = 4
	
	bullet.splitinto = splitter
	bullet.direction = position.direction_to(get_global_mouse_position())
	bullet.position = position
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
