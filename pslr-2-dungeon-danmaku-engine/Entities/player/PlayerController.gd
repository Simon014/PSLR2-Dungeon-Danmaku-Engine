extends CharacterBody2D

var attackhandler = coreDungeonEngine.AttackHandler.new()

#attack iterating stats. saved locally.
var AttackIterating = 0 #0 : no attack being iterated through. x : x attack being iterated through.
var AttackCounter = 0
var TotalBullets = 10
var frametime
var isdead = false
var atk = corePlayerVars.attack
var defence = corePlayerVars.defence

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
	bullet.speed = 100
	bullet.acceleration = 0.1
	bullet.split = 4
	bullet.color = Color(1.0, 0.564, 0.312, 1.0)
	bullet.image = "DebugBullet2.png"
	bullet.friendly = true
	var splitter = load("res://Entities/bullets/homing/Bullet.tscn").instantiate()
	splitter.friendly = false
	splitter.TTL = 10
	splitter.damage = 100
	splitter.color = Color(1.0, 0.564, 0.312, 1.0)
	splitter.direction = Vector2.DOWN
	bullet.splitinto = splitter
	bullet.direction = position.direction_to(get_global_mouse_position())
	attackhandler.DRattackIterate(self, position, bullet, AttackCounter, func(x): return x * 10)
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
	print(corePlayerVars.Health)
	corePlayerVars.position = position
	frametime = delta


func _on_atkcd_timeout() -> void:
	if (corePlayerVars.Health < 0):
		queue_free()
		get_tree().quit()
	else:
		if (corePlayerVars.Health < corePlayerVars.maxhealth):
			corePlayerVars.Health += coreGlobalConst.passiveheal * frametime
		else:
			corePlayerVars.Health = corePlayerVars.maxhealth #clamp to max health
	if (corePlayerVars.PoisonRemaining > 0):
		corePlayerVars.PoisonRemaining -= 1
		corePlayerVars.Health -= coreGlobalConst.poisonpower * frametime

			
	if (corePlayerVars.SlowRemaining > 0):
		corePlayerVars.SlowRemaining -= 1
		
	if (corePlayerVars.AtkLowerRemaining > 0):
		corePlayerVars.AtkLowerRemaining -= 1
		atk = corePlayerVars.attack * coreGlobalConst.lowatk
	else:
		atk = corePlayerVars.attack
		
	if (corePlayerVars.DefLowerRemaining > 0):
		corePlayerVars.DefLowerRemaining -= 1
		defence = corePlayerVars.defence * coreGlobalConst.lowdef
	else:
		defence = corePlayerVars.defence
		
	if AttackIterating != 0:
		attack()
	for i in $DetectionArea.get_overlapping_bodies():
		if (i.friendly == false):
			if (i.name.contains("Bullet")):
				if position.distance_to(i.position) < 10:
					i.queue_free()
					if (not isdead):
						corePlayerVars.Health -= i.damage	* (100-corePlayerVars.defence)/100
			if (i.name.contains("Effect")):
				if (not isdead):
					if (position.distance_to(i.position) < i.effectRadius):
						if (i.effect == "poison"):
							corePlayerVars.PoisonRemaining = i.effectDuration
						if (i.effect == "speed down"):
							corePlayerVars.SlowRemaining = i.effectDuration
						if (i.effect == "lower defence"):
							corePlayerVars.DefLowerRemaining = i.effectDuration
						if (i.effect == "lower attack"):
							corePlayerVars.AtkLowerRemaining = i.effectDuration
			if (i.name.contains("Bomb")):
				if position.distance_to(i.position) < i.explosionRadius * 0.95 and i.iexploded() == false:
					i.queue_free()
					if (not isdead):
						corePlayerVars.Health -= i.damage * i.explosionDamage	* (100-corePlayerVars.defence)/100
				elif position.distance_to(i.position) < 10:
					i.queue_free()
					if (not isdead):
						corePlayerVars.Health -= i.damage	* (100-corePlayerVars.defence)/100
			if (i.name.contains("lazer")):
				var distToLazer = position.distance_to(i.position)*(asin(i.position.direction_to(position).angle() - i.direction.angle()))
				if ((abs(distToLazer) < i.width * 20) and i.isactive()):
					if (not isdead):
						corePlayerVars.Health -= i.damage * frametime	* (100-corePlayerVars.defence)/100
			else:
				
				pass
	pass # Replace with function body.
