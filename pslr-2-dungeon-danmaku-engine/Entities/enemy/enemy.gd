extends CharacterBody2D

var movementvector
var frametime
var isdead

@export var attack: Attack = null

#combat info
var defence = 10
var atk = 10
var health = 100
var atkspeed = 100
var Maxhealth = 100
var attackhandler = coreDungeonEngine.AttackHandler.new()
var attackExecutor

var PoisonRemaining = 0
var SlowRemaining = 0
var DefLowerRemaining = 0
var AtkLowerRemaining = 0

#attack iterating stats. saved locally.
var AttackIterating = 0 #0 : no attack being iterated through. x : x attack being iterated through.
var AttackCounter = 0
var TotalBullets = 0

func attackIterate():
	AttackIterating = 1
	TotalBullets = 10
	AttackCounter = 0
	pass

func _ready() -> void:
	attackExecutor = $AttackExecutorManager
	pass
	#this function will load current dungeon variables in RAM. for now it does nothing.

func attack1():
	#attack.Execute(self, position.direction_to(get_global_mouse_position()))
	pass
	
func _on_atkcd_timeout() -> void:
	attackExecutor.ExecuteNewAttack(attack)
	pass # Replace with function body.d
		
func _process(delta: float) -> void:
	frametime = delta

func _on_tick_timeout() -> void:
	if AttackIterating != 0:
		attack1()
	if (health < 0):
		isdead = true
		health = 0
		PoisonRemaining = 0
		queue_free()
	else:
		if (health < Maxhealth):
			health += coreGlobalConst.passiveheal * frametime
		else:
			health = Maxhealth #clamp to max health
	if (PoisonRemaining > 0):
		PoisonRemaining -= 1
		health -= coreGlobalConst.poisonpower * frametime

			
	if (SlowRemaining > 0):
		SlowRemaining -= 1
		
	#if (AtkLowerRemaining > 0):
		#AtkLowerRemaining -= 1
		#atk = attack * coreGlobalConst.lowatk
	#else:
		#atk = attack
		
	if (DefLowerRemaining > 0):
		DefLowerRemaining -= 1
		defence = defence * coreGlobalConst.lowdef
	else:
		defence = defence
		
	for i in $DetectionArea.get_overlapping_bodies():
		movementvector = Vector2.ZERO
		if (i.friendly == true):
			if (i.name.contains("Bullet")):
				if position.distance_to(i.position) < 10:
					i.queue_free()
					if (not isdead):
						health -= i.damage	* (100-defence)/100
			if (i.name.contains("Effect")):
				if (not isdead):
					if (position.distance_to(i.position) < i.effectRadius):
						if (i.effect == "poison"):
							PoisonRemaining = i.effectDuration
						if (i.effect == "speed down"):
							SlowRemaining = i.effectDuration
						if (i.effect == "lower defence"):
							DefLowerRemaining = i.effectDuration
						if (i.effect == "lower attack"):
							AtkLowerRemaining = i.effectDuration
				movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
			if (i.name.contains("Bomb")):
				if position.distance_to(i.position) < i.explosionRadius * 0.95 and i.iexploded() == false:
					i.queue_free()
					if (not isdead):
						health -= i.damage * i.explosionDamage	* (100-defence)/100
				elif position.distance_to(i.position) < 10:
					i.queue_free()
					if (not isdead):
						health -= i.damage	* (100-defence)/100
			if (i.name.contains("lazer")):
				var distToLazer = position.distance_to(i.position)*(asin(i.position.direction_to(position).angle() - i.direction.angle()))
				if ((abs(distToLazer) < i.width * 20) and i.isactive()):
					if (not isdead):
						health -= i.damage * frametime	* (100-defence)/100
			else:
				
				pass
	pass # Replace with function body.
