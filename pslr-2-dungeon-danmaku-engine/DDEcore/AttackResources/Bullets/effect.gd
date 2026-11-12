extends Bullet
class_name effect

@export_enum("poison","speed down","lower defence","lower attack") var appliedEffect: String
@export var EffectRadius: int = 30
@export var EffectDuration: int = 40

func Create(ExecutorObject: CharacterBody2D,direction: Vector2) -> CharacterBody2D:
	var bullet = load("res://Entities/bullets/effect/Bullet.tscn").instantiate()
	bullet.TTL = TTL
	bullet.friction = friction
	bullet.acceleration = acceleration
	bullet.direction = direction
	bullet.position = ExecutorObject.position
	bullet.color = color
	bullet.image = image
	bullet.effect = appliedEffect
	bullet.effectDuration = EffectDuration
	bullet.effectRadius = EffectRadius
	bullet.friendly = friendly
	ExecutorObject.get_parent().add_child(bullet)
	return bullet
