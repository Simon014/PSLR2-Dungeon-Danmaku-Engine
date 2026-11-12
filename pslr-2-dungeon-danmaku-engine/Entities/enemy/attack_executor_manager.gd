extends Node

var activeAttack: Array[Attack]
var activeFunc: String
var mathHandler = Expression.new()
var AttackCounter = 0
#iterative variables
var iteration = 0
var maxbullets
var isactive = false
var current: Attack = null
var threshold = 0.05

func _ready() -> void:
	pass
	
func ExecuteNewAttack(atklist: Array[Attack]) -> void:
	if isactive:
		return 
	else:
		#clear the previous list.
		activeAttack.clear()
		AttackCounter = 0
		for atk in atklist:
			#check 1 : all fields have been filled out.
			if atk == null or atk.bullet == null or atk.shape == null:
				print("Not all fields have been filled out. skipping.")
				continue
			#check 2 : is the math function valid ?
			mathHandler.parse(atk.shape.MathFunction, ["x"])
			if mathHandler.get_error_text() != "":
				print("Math function invalid : " + mathHandler.get_error_text())
				continue
			#if all checks are good, check if it uses modified stats.
			if atk.UseEntityStats:
				atk.bullet.damage = get_parent().atk
				atk.bullet.speed = get_parent().atkspeed
			for i in range(atk.Repeat):
				activeAttack.append(atk)
		print(str(len(activeAttack)) + " out of " + str(len(atklist)) + " attacks succesfully initalized")
		isactive = true

func _on_timer_timeout() -> void:
	if len(activeAttack) == 0 and current == null:
		print("no attack initalised.")
		isactive = false
		pass
	if current == null:
		#get the next attack for the next tick.
		if len(activeAttack) != 0:
			current = activeAttack.pop_front()
	else:
		#cartesian renderer portion.
		if (current.shape.Type == "Cartesian"):
			mathHandler.parse(current.shape.MathFunction, ["x"])
			if (current.shape.Mode == "Iterative"):
				
				if iteration > current.shape.Var1:
					current = null
					iteration = 0
				else:
					CartesianRender(current, iteration - current.shape.Var1 / 2)
					iteration += 1
			elif (current.shape.Mode == "Full"):
				for i in range(current.shape.Var1):
					CartesianRender(current, i - current.shape.Var1 / 2)
				current = null
		elif (current.shape.Type == "Directional"):
			mathHandler.parse(current.shape.MathFunction, ["x"])
			if (current.shape.Mode == "Iterative"):
				if iteration > current.shape.var2:
					current = null
					iteration = 0
				else:
					DirectionalRender(current, iteration)
					iteration += 1
			elif (current.shape.Mode == "Full"):
				for i in range(current.shape.Var1, current.shape.var2):
					DirectionalRender(current, i)
				current = null
		
		#get the next a
	pass # Replace with function body.

func CartesianRender(atk: Attack, number: int) -> void:
	if atk.shape.AimingPosition == "Partner":
		var newBullet = atk.bullet.Create(get_parent(), get_parent().position.direction_to(corePartnerVars.position))
		newBullet.position = Vector2(get_parent().position.x -number * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([number])*atk.shape.var2)
	elif atk.shape.AimingPosition == "Player":
		var newBullet = atk.bullet.Create(get_parent(), get_parent().position.direction_to(corePlayerVars.position))
		newBullet.position = Vector2(get_parent().position.x -number * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([number])*atk.shape.var2)
	elif atk.shape.var3 != Vector2.ZERO:
		var newBullet = atk.bullet.Create(get_parent(), atk.shape.var3)
		newBullet.position = Vector2(get_parent().position.x -number * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([number])*atk.shape.var2)
	else:
		var newBullet = atk.bullet.Create(get_parent(), Vector2.DOWN)
		newBullet.position = Vector2(get_parent().position.x -number * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([number])*atk.shape.var2)
	pass
	
func DirectionalRender(atk: Attack, number: int):
	# function defines the direction the bullet will go in. all other variables do not matter.
	atk.bullet.Create(get_parent(), Vector2.from_angle(deg_to_rad(mathHandler.execute([number]))))
	pass
