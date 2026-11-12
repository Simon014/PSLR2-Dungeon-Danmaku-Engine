extends Bullet
class_name homing
@export_group("pathing")
@export var pathstart: float = 5

func Create(ExecutorObject: CharacterBody2D,direction: Vector2) -> CharacterBody2D:
	var bullet = load("res://Entities/bullets/homing/Bullet.tscn").instantiate()
	bullet.damage = damage
	bullet.speed = speed
	bullet.TTL = TTL
	bullet.friction = friction
	bullet.acceleration = acceleration
	bullet.direction = direction
	bullet.position = ExecutorObject.position
	bullet.color = color
	bullet.image = image
	bullet.Pathstart = pathstart
	bullet.friendly = friendly
	ExecutorObject.get_parent().add_child(bullet)
	return bullet
