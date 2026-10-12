extends CharacterBody2D

var movementvector

func attack():
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.speed = corePlayerVars.attackspeed
	bullet.damage = corePlayerVars.attack * 10
	bullet.direction = position.direction_to(get_global_mouse_position())
	bullet.position = position
	get_parent().add_child(bullet)
	pass
		
func _process(delta: float) -> void:
	if ($StunCD.time_left == 0):
		move_and_slide()
	corePartnerVars.position = position

func _on_tick_timeout() -> void:
	#handle effects :
	if (corePartnerVars.PoisonRemaining > 0):
		corePartnerVars.PoisonRemaining -= 1
	if (corePartnerVars.SlowRemaining > 0):
		corePartnerVars.SlowRemaining -= 1
	if (corePartnerVars.AtkLowerRemaining > 0):
		corePartnerVars.AtkLowerRemaining -= 1
	if (corePartnerVars.DefLowerRemaining > 0):
		corePartnerVars.DefLowerRemaining -= 1
	movementvector = Vector2.ZERO
	if (not $DetectionArea.has_overlapping_bodies() and position.distance_to(corePlayerVars.position) > corePartnerVars.followdist):
		movementvector = position.direction_to(corePlayerVars.position)
	else:
		pass
	for i in $DetectionArea.get_overlapping_bodies():
		if (i.name.contains("Bullet")):
			if position.distance_to(i.position) < 10:
				i.queue_free()
				$StunCD.start()
			elif position.distance_to(i.position) < 20:
				movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
		if (i.name.contains("Effect")):
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
			if position.distance_to(i.position) < i.currentarea():
				i.queue_free()
				$StunCD.start()
			elif position.distance_to(i.position) < i.explosionRadius*1.1:
				movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
		if (i.name.contains("lazer")):
			var distToLazer = position.distance_to(i.position)*(asin(i.position.direction_to(position).angle() - i.direction.angle()))
			print(distToLazer)
			print(i.position.direction_to(position).angle() - i.direction.angle())
			if (abs(distToLazer) < i.width * 20):
				$StunCD.start()
			elif(i.position.direction_to(position).angle() - i.direction.angle() > 0):
				movementvector += Vector2.from_angle(i.direction.angle() + PI/2)
				pass
			elif(i.position.direction_to(position).angle() - i.direction.angle() < 0):
				movementvector += Vector2.from_angle(i.direction.angle() - PI/2)
				pass
			#calc direction and distance to origin
			#calc perpendicular angle to lazer, from kemoko (and if needed, do it depending on where Kemoko is against the direction of the lazer.
			#find the angle between the perpendicular and the origin, then calculate distance to lazer invisible line.
	movementvector = movementvector.normalized()
	velocity = movementvector.normalized() * corePartnerVars.speed 
	pass # Replace with function body.
