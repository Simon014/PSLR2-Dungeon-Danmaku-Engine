extends Resource
class_name Bullet #bullet super class. used for normal bullets. all other bullets inherits from this.
@export_group("General Stats")
@export var damage = 10.0
@export var speed = 100.0
@export var TTL = 5
@export var friction = 0.0
@export var acceleration = 0.0
@export var friendly = false
@export_group("visuals")
@export_file_path(".png") var image: String
@export var color = Color(1.0, 1.0, 1.0, 1.0)

func Create(ExecutorObject: CharacterBody2D,direction: Vector2) -> CharacterBody2D:
	var bullet = load("res://Entities/bullets/normal/Bullet.tscn").instantiate()
	bullet.damage = damage
	bullet.speed = speed
	bullet.TTL = TTL
	bullet.friction = friction
	bullet.acceleration = acceleration
	bullet.direction = direction
	bullet.position = ExecutorObject.position
	bullet.color = color
	bullet.image = image
	bullet.friendly = friendly
	ExecutorObject.get_parent().add_child(bullet)
	return bullet
