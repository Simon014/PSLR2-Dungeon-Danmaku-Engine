extends CharacterBody2D

var attackhandler = coreDungeonEngine.AttackHandler.new()

func attack():
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.position = position
	bullet.TTL = 5
	bullet.speed = 0
	bullet.acceleration = 0.1
	bullet.split = 8
	bullet.color = Color(1.0, 0.564, 0.312, 1.0)
	bullet.image = "DebugBullet2.png"
	bullet.friendly = true
	var splitter = load("res://Entities/bullets/bomb/Bullet.tscn").instantiate()
	splitter.friendly = true
	splitter.speed = 300
	splitter.acceleration = -1
	splitter.TTL = 2
	splitter.color = Color(1.0, 0.564, 0.312, 1.0)
	splitter.image = "DebugBullet2.png"
	bullet.splitinto = splitter
	bullet.direction = position.direction_to(get_global_mouse_position())
	attackhandler.CSAttackFull(self,position,bullet,100,func(x): return 1/pow(x,1/2) * tan(x),10)
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
