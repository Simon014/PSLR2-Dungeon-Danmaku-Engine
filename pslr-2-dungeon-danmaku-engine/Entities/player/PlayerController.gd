extends CharacterBody2D

var attackhandler = coreDungeonEngine.AttackHandler.new()

#attack iterating stats. saved locally.
var AttackIterating = 0 #0 : no attack being iterated through. x : x attack being iterated through.
var AttackCounter = 0
var TotalBullets = 10

func attackIterate():
	AttackIterating = 1
	TotalBullets = 100
	AttackCounter = 0
	pass

func attack():
	if AttackIterating != 0:
		if AttackCounter == TotalBullets:
			AttackIterating = 0
			return
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.position = position
	bullet.TTL = 5
	bullet.speed = 0
	bullet.acceleration = 0.1
	bullet.split = 4
	bullet.color = Color(1.0, 0.564, 0.312, 1.0)
	bullet.image = "DebugBullet2.png"
	bullet.friendly = true
	var splitter = load("res://Entities/bullets/lazer/lazer.tscn").instantiate()
	splitter.friendly = true
	splitter.TTL = 10
	splitter.color = Color(1.0, 0.564, 0.312, 1.0)
	splitter.direction = Vector2.DOWN
	bullet.splitinto = splitter
	bullet.direction = position.direction_to(get_global_mouse_position())
	attackhandler.CSAttackIterate(self,position,bullet,AttackCounter - TotalBullets/2,func(x): return 1/pow(x,1/2) * 1/cos(2*x),10)
	AttackCounter += 1
	pass

func _input(event: InputEvent) -> void:
	velocity = Input.get_vector("left", "right","up","down") * corePlayerVars.speed
	if (Input.is_action_pressed("slowdown")):
		velocity = velocity / 3
	
	if (Input.is_action_just_pressed("SPAttack1")):
		if AttackIterating == 1:
			pass
		else:
			attackIterate()
	pass
		
func _process(delta: float) -> void:
	move_and_slide()
	corePlayerVars.position = position


func _on_atkcd_timeout() -> void:
	if AttackIterating != 0:
		attack()
	pass # Replace with function body.
