extends Resource
class_name Attack

@export var bullet: Bullet
@export var shape: Shape

@export_group("Attack Settings")
@export var Repeat: int = 1
@export var UseEntityStats: bool = false
#bullet stats will use the combat stats of the enemy, where possible.
#ie, damage, attack speed etc.
