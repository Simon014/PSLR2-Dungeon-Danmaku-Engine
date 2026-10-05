extends CharacterBody2D

func attack():
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.speed = corePlayerVars.attackspeed
	bullet.damage = corePlayerVars.attack * 10
	bullet.split = 10
	bullet.TTL = 2
	bullet.direction = position.direction_to(get_global_mouse_position())
	bullet.position = position
	var splitter = load("res://Entities/bullets/normal/Bullet.tscn").instantiate()
	splitter.name = "splitter"
	splitter.acceleration = -10
	splitter.TTL = 5
	bullet.splitinto = splitter
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
