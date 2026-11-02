extends Node

class AttackHandler:
	#this function graphs the full cartesian plane attack, in the domain [-bullet_number, bullet_number]. function can be scaled using multiplier.
	func CSAttackFull(executorObject: CharacterBody2D, Position: Vector2, Bullet_Type, Bullet_number: int, Function: Callable, Multiplier: int, AimToPosition = null):
		for i in range(-Bullet_number, Bullet_number):
			if i == 0:
				i += 1
			var NewPosition = Vector2(Position.x - i*Multiplier,Position.y - Function.call(i)*Multiplier )
			var NewBullet = Bullet_Type.duplicate()
			NewBullet.position = NewPosition
			if AimToPosition:
				NewBullet.direction = NewBullet.position.direction_to(AimToPosition)
			else:
				NewBullet.direction = Bullet_Type.direction
			executorObject.get_parent().add_child(NewBullet)
			pass
	
	#this function graphs a single point of a Cartesian plane attack. bullet_number specifies the input value of the function, not range. it is up to the executor object
	#to handle iterating through.
	func CSAttackIterate(executorObject: CharacterBody2D, Position: Vector2, Bullet_Type, Bullet_number: int, Function: Callable, Multiplier: int, AimToPosition = null):
		if Bullet_number == 0:
			Bullet_number += 1
		var NewPosition = Vector2(Position.x - Bullet_number*Multiplier,Position.y - Function.call(Bullet_number)*Multiplier )
		var NewBullet = Bullet_Type.duplicate()
		NewBullet.position = NewPosition
		if AimToPosition:
			NewBullet.direction = NewBullet.position.direction_to(AimToPosition)
		else:
			NewBullet.direction = Bullet_Type.direction
		executorObject.get_parent().add_child(NewBullet)
		#area is the valid range of this function. If a number is outputed beyond this range, it is clamped
		#to the area maximum
		
		#direction should be set automatically by the entity that called this function.
		
		pass
		
	#Direction attack : inputted function outputs the direction of the bullet.
	func DRAttackFull(executorObject: CharacterBody2D, Position: Vector2, Bullet_Type, start: int, end: int, Function: Callable):
		for i in range(start, end):
			var newbullet = Bullet_Type.duplicate()
			newbullet.direction = Vector2.from_angle(deg_to_rad(Function.call(i)))
			newbullet.position = Position
			executorObject.get_parent().add_child(newbullet)
			pass
		pass
	
	func DRattackIterate(executorObject: CharacterBody2D, Position: Vector2, Bullet_Type, input: int, Function: Callable):
		var newbullet = Bullet_Type.duplicate()
		newbullet.direction = Vector2.from_angle(deg_to_rad(Function.call(input)))
		newbullet.position = Position
		executorObject.get_parent().add_child(newbullet)
		pass



class Bullet:
	
	var damage
	var speed
	var TTL
	var friction
	var acceleration
	var color
	var image
	
	func _init(damage: int = 0, speed: int = 100, TTL: int = 5, friction: float = 0, acceleration: float = 0, color: Color = Color(1.0, 1.0, 1.0, 1.0), image = "DebugBullet.png") -> void:
		self.damage = damage
		self.speed = speed
		self.TTL = TTL
		self.friction = friction
		self.acceleration = acceleration
		self.color = color
		self.image = image
		pass
		
class Split:
	extends Bullet
	var split
	var splitinto
	func _init(damage: int = 0, speed: int = 100, TTL: int = 5, friction: float = 0, acceleration: float = 0, color: Color = Color(1.0, 1.0, 1.0, 1.0), image = "DebugBullet.png", split: int = 4, splitinto: Bullet = Bullet.new()) -> void:
		super(damage, speed, TTL, friction, acceleration, color, image)
		self.split = split
		self.splitinto = splitinto
		pass

class homing:
	extends Bullet
	var pathstart
	func _init(damage: int = 0, speed: int = 100, TTL: int = 5, friction: float = 0, acceleration: float = 1, color: Color = Color(1.0, 1.0, 1.0, 1.0), image = "DebugBullet.png", pathstart: int = 5) -> void:
		super(damage, speed, TTL, friction, acceleration, color, image)
		self.pathstart = pathstart
		pass
		
class bomb:
	extends Bullet
	var explosionRadius
	var ExplosionDamage
	func _init(damage: int = 0, speed: int = 100, TTL: int = 5, friction: float = 0, acceleration: float = 0, color: Color = Color(1.0, 1.0, 1.0, 1.0), image = "DebugBullet.png", explosionRadius: int = 30, explosionDamage: float = 0.5) -> void:
		self.explosionRadius = explosionRadius
		self.ExplosionDamage = explosionDamage
		pass
		
class effect:
	extends Bullet
	var effect
	var effectDuration
	var effectRadius
	func _init(damage: int = 0, speed: int = 100, TTL: int = 5, friction: float = 0, acceleration: float = 0, color: Color = Color(1.0, 1.0, 1.0, 1.0), image = "DebugBullet.png", effect: String = "poison", effectRadius: float = 30, effectDuration: int = 40) -> void:
		self.effect = effect
		self.effectDuration = effectDuration
		self.effectRadius = effectRadius

class lazer:
	var damage
	var TTL
	var width
	var warntime
	var color
	func _init(damage: int = 0, TTL: int = 5, width: float = 30, warntime: int = 1, color: Color = Color(1.0, 1.0, 1.0, 1.0)) -> void:
		self.damage = damage
		self.TTL = TTL
		self.width = width
		self.warntime = warntime
		self.color = color
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
