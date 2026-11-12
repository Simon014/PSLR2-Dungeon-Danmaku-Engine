extends CharacterBody2D

#attack iterating stats. saved locally.
var AttackIterating = 0 #0 : no attack being iterated through. x : x attack being iterated through.
var AttackCounter = 0
var TotalBullets = 10
var frametime
var isdead = false
var atk = corePlayerVars.attack
var defence = corePlayerVars.defence
var speed = corePlayerVars.speed
var atkspeed = corePlayerVars.attackspeed
var attackExecutor

@export var WeakAttackBullet = Bullet.new()
@export_group("SP attacks")

@export var attack1: AttackSet
@export var attack2: AttackSet
@export var attack3: AttackSet

func _ready() -> void:
	attackExecutor = $AttackExecutorManager
	WeakAttackBullet.damage = atk
	WeakAttackBullet.speed = atkspeed
	pass



	

func _input(event: InputEvent) -> void:
	if (corePlayerVars.SlowRemaining):
		velocity = Input.get_vector("left", "right","up","down") * speed * coreGlobalConst.slowdownpower
	else:
		velocity = Input.get_vector("left", "right","up","down") * speed
	if (Input.is_action_pressed("slowdown")):
		velocity = velocity / 3
	
	if (Input.is_action_just_pressed("SPAttack1")):
		attackExecutor.ExecuteNewAttack(attack1.Set)
	if (Input.is_action_just_pressed("SPAttack2")):
		attackExecutor.ExecuteNewAttack(attack2.Set)
	if (Input.is_action_just_pressed("SPAttack3")):
		attackExecutor.ExecuteNewAttack(attack3.Set)
func _process(delta: float) -> void:
	move_and_slide()
	corePlayerVars.position = position
	frametime = delta
	

func _on_atkcd_timeout() -> void:
	if (Input.is_action_pressed("shoot normal")):
		WeakAttackBullet.Create(self, position.direction_to(get_global_mouse_position()))
		pass
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
	for i in $DetectionArea.get_overlapping_bodies():
		if (i.friendly == false):
			if (not i.name.contains("Effect")):
				if (i.wasdodged == false):
					i.wasdodged = true
					coreDungeonStats.dodges += 1
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
				if position.distance_to(i.position) < i.explosionRadius * 0.95 and i.iexploded() == true:
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
