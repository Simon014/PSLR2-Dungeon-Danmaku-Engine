extends CharacterBody2D

var movementvector
var frametime
var isdead
var defence = corePartnerVars.defence
var atk = corePartnerVars.attack

func attack(direction):
	#var bullet = load("res://Entities/bullets/normal/Bullet.tscn").instantiate()
	#bullet.speed = corePlayerVars.attackspeed
	#bullet.damage = 10 * atk
	#bullet.direction = direction
	#bullet.color = Color(1.0, 0.409, 0.926, 1.0)
	#bullet.position = position
	#bullet.TTL = 10
	#bullet.friendly = true
	#get_parent().add_child(bullet)
	pass
		
func _process(delta: float) -> void:
	frametime = delta
	
	if ($StunCD.time_left == 0):
		move_and_slide()
	corePartnerVars.position = position

func _on_tick_timeout() -> void:
	corePartnerVars.isdead = isdead
		
	
	#handle effects :
	if (corePartnerVars.Health < 0):
		$StunCD.start()
		isdead = true
		corePartnerVars.Health = 0
		corePartnerVars.PoisonRemaining = 0
	else:
		if (corePartnerVars.Health < corePartnerVars.MaxHealth):
			corePartnerVars.Health += coreGlobalConst.passiveheal * frametime
		else:
			corePartnerVars.Health = corePartnerVars.MaxHealth #clamp to max health
	if (corePartnerVars.PoisonRemaining > 0):
		corePartnerVars.PoisonRemaining -= 1
		corePartnerVars.Health -= coreGlobalConst.poisonpower * frametime

			
	if (corePartnerVars.SlowRemaining > 0):
		corePartnerVars.SlowRemaining -= 1
		
	if (corePartnerVars.AtkLowerRemaining > 0):
		corePartnerVars.AtkLowerRemaining -= 1
		atk = corePartnerVars.attack * coreGlobalConst.lowatk
	else:
		atk = corePartnerVars.attack
		
	if (corePartnerVars.DefLowerRemaining > 0):
		corePartnerVars.DefLowerRemaining -= 1
		defence = corePartnerVars.defence * coreGlobalConst.lowdef
	else:
		defence = corePartnerVars.defence
		
	#handle movement
	movementvector = Vector2.ZERO
	if (not $DetectionArea.has_overlapping_bodies() and position.distance_to(corePlayerVars.position) > corePartnerVars.followdist):
		movementvector = position.direction_to(corePlayerVars.position)
	else:
		pass
	for i in $DetectionArea.get_overlapping_bodies():
		if (i.friendly == false):
			if (i.name.contains("Bullet")):
				if position.distance_to(i.position) < 10:
					i.queue_free()
					if (not isdead):
						corePartnerVars.Health -= i.damage	* (100-defence)/100
				elif position.distance_to(i.position) < 20:
					movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
			if (i.name.contains("Effect")):
				if (not isdead):
					if (position.distance_to(i.position) < i.effectRadius):
						if (i.effect == "poison"):
							corePartnerVars.PoisonRemaining = i.effectDuration
						if (i.effect == "speed down"):
							corePartnerVars.SlowRemaining = i.effectDuration
						if (i.effect == "lower defence"):
							corePartnerVars.DefLowerRemaining = i.effectDuration
						if (i.effect == "lower attack"):
							corePartnerVars.AtkLowerRemaining = i.effectDuration
				movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
			if (i.name.contains("Bomb")):
				if position.distance_to(i.position) < i.explosionRadius * 0.95 and i.iexploded() == false:
					i.queue_free()
					if (not isdead):
						corePartnerVars.Health -= i.damage * i.explosionDamage	* (100-defence)/100
				elif position.distance_to(i.position) < 10:
					i.queue_free()
					if (not isdead):
						corePartnerVars.Health -= i.damage	* (100-defence)/100
				elif position.distance_to(i.position) < i.explosionRadius*1.2:
					movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
			if (i.name.contains("lazer")):
				var distToLazer = position.distance_to(i.position)*(asin(i.position.direction_to(position).angle() - i.direction.angle()))
				if ((abs(distToLazer) < i.width * 20) and i.isactive()):
					if (not isdead):
						corePartnerVars.Health -= i.damage * frametime	* (100-defence)/100
				elif(i.position.direction_to(position).angle() - i.direction.angle() > 0):
					movementvector += Vector2.from_angle(i.direction.angle() + PI/2)
					pass
				elif(i.position.direction_to(position).angle() - i.direction.angle() < 0):
					movementvector += Vector2.from_angle(i.direction.angle() - PI/2)
					pass
				else:
					movementvector += Vector2.from_angle(i.direction.angle() - PI/2)
				#calc direction and distance to origin
				#calc perpendicular angle to lazer, from kemoko (and if needed, do it depending on where Kemoko is against the direction of the lazer.
				#find the angle between the perpendicular and the origin, then calculate distance to lazer invisible line.
			else:
				
				pass
	movementvector = movementvector.normalized()
	if (corePartnerVars.SlowRemaining > 0):
		velocity = movementvector.normalized() * corePartnerVars.speed * coreGlobalConst.slowdownpower
	else:
		velocity = movementvector.normalized() * corePartnerVars.speed 
	pass # Replace with function body.


func _on_stun_cd_timeout() -> void:
	#insta heal 25% of health.
	corePartnerVars.Health = corePartnerVars.MaxHealth * coreGlobalConst.partnerstunheal
	isdead = false
	pass # Replace with function body.


func _on_atkcd_timeout() -> void:
		#handle attack
	if (not isdead):
		for i in get_parent().get_children():
			if (i.name.contains("Enemy")):
				attack(position.direction_to(i.position))
				break
	pass # Replace with function body.
