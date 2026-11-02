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
