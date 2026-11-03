extends Bullet
class_name lazer

@export var width = 30
@export var warningTime: int

func Create(ExecutorObject: CharacterBody2D,direction: Vector2) -> CharacterBody2D:
	var bullet = load("res://Entities/bullets/lazer/lazer.tscn").instantiate()
	bullet.damage = damage
	bullet.width = width
	bullet.TTL = TTL
	bullet.color = color
	bullet.warningtime = warningTime
	bullet.direction = direction
	bullet.position = ExecutorObject.position
	bullet.friendly = friendly
	ExecutorObject.get_parent().add_child(bullet)
	return bullet
