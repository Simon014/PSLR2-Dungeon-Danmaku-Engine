extends Bullet
class_name bomb

@export_group("bomb configurations")
@export var explosionRadius = 30
@export var explosionDamage = 0.5
@export_file_path(".png") var explosionImage: String

func Create(ExecutorObject: CharacterBody2D,direction: Vector2) -> CharacterBody2D:
	var bullet = load("res://Entities/bullets/bomb/Bullet.tscn").instantiate()
	bullet.damage = damage
	bullet.speed = speed
	bullet.TTL = TTL
	bullet.friction = friction
	bullet.acceleration = acceleration
	bullet.direction = direction
	bullet.position = ExecutorObject.position
	bullet.color = color
	bullet.image = image
	bullet.explosionRadius = explosionRadius
	bullet.explosionDamage = explosionDamage
	bullet.explosionImage = explosionImage
	bullet.friendly = friendly
	ExecutorObject.get_parent().add_child(bullet)
	return bullet
