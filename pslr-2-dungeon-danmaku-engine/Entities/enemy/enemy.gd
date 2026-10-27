extends CharacterBody2D

var movementvector
var frametime
var isdead
var defence = corePartnerVars.defence
var atk = corePartnerVars.attack

func attack():
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.speed = 100
	bullet.damage = 10 * atk
	bullet.split = 3
	bullet.color = Color(0.918, 0.911, 0.0, 1.0)
	var split = load("res://Entities/bullets/bomb/Bullet.tscn").instantiate()
	split.acceleration = 1
	split.damage = 100
	split.TTL = 1
	split.explosionRadius = 30
	split.explosionDamage = 0.75
	split.color = Color(1.0, 0.559, 0.636, 1.0)
	bullet.splitinto = split
	if(position.distance_to(corePlayerVars.position) < position.distance_to(corePartnerVars.position) or corePartnerVars.isdead == true):
		bullet.direction = position.direction_to(corePlayerVars.position)
	else:
		bullet.direction = position.direction_to(corePartnerVars.position)
	bullet.position = position
	get_parent().add_child(bullet)
	pass
	
func _on_atkcd_timeout() -> void:
	attack()
	pass # Replace with function body.
		
func _process(delta: float) -> void:
	frametime = delta
	
	if ($StunCD.time_left == 0):
		move_and_slide()


func _on_stun_cd_timeout() -> void:
	#insta heal 25% of health.
	corePartnerVars.Health = corePartnerVars.MaxHealth * coreGlobalConst.partnerstunheal
	isdead = false
	pass # Replace with function body.
