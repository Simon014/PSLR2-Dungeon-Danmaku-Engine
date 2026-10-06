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

func _on_dodge_timeout() -> void:
	movementvector = Vector2.ZERO
	if (not $DetectionArea.has_overlapping_bodies() and position.distance_to(corePlayerVars.position) > 100):
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
		if (i.name.contains("Bomb")):
			if position.distance_to(i.position) < i.currentarea():
				i.queue_free()
				$StunCD.start()
			elif position.distance_to(i.position) < i.explosionRadius*1.1:
				movementvector -= position.direction_to(i.position) * 0.1/position.distance_to(i.position)
	movementvector = movementvector.normalized()
	velocity = movementvector.normalized() * corePartnerVars.speed 
	pass # Replace with function body.
