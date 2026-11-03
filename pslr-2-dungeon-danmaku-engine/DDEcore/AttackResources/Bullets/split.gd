extends Bullet
class_name split
@export_group("spliter configuration")
@export var Amount = 4.0
@export var splitBullet: Bullet

func Create(ExecutorObject: CharacterBody2D,direction: Vector2) -> CharacterBody2D:
	var bullet = load("res://Entities/bullets/split/Bullet.tscn").instantiate()
	bullet.damage = damage
	bullet.speed = speed
	bullet.TTL = TTL
	bullet.friction = friction
	bullet.acceleration = acceleration
	bullet.direction = direction
	bullet.position = ExecutorObject.position
	bullet.splitinto = splitBullet
	bullet.spliting = Amount
	bullet.friendly = friendly
	bullet.color = color
	bullet.image = image
	ExecutorObject.get_parent().add_child(bullet)
	return bullet
