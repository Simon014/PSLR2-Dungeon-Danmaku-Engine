extends Node

var activeAttack: Array[Attack]
var activeFunc: String
var mathHandler = Expression.new()
var timer = 0
#iterative variables
var iteration = 0
var maxbullets
var isactive = false
var current = null
var threshold = 0.05

func _ready() -> void:
	pass
	
func ExecuteNewAttack(atklist: Array[Attack]) -> void:
	for atk in atklist:
		if isactive:
			pass
		else:
			if (atk.shape == null and atk.bullet == null):
				pass
			else:
				mathHandler.parse(atk.shape.MathFunction, ["x"])
				if (mathHandler.get_error_text() != "") :
					printerr("Inputted Math Function not valid !: " + mathHandler.get_error_text())
				else:
					activeAttack.append(atk)
	isactive = true
	current = activeAttack.pop_front()
	pass

func _process(delta: float) -> void:
	#first, create a manual timer
	timer += delta
	if timer > threshold:
		timer = 0
		#execute attack.
		if isactive == false:
			pass
		else:
			if current != null:
				mathHandler.parse(current.shape.MathFunction, ["x"])
				if (current.shape.Type == "Cartesian"):
					if (current.shape.Mode == "Full"):
						CartesianFull()
						current = activeAttack.pop_front()
					elif (current.shape.Mode == "Iterative"):
						CartesianIter()
						iteration += 1
						threshold = 0.0
						if (iteration == current.shape.Var1):
							iteration = 0
							threshold = 0.05
							current = activeAttack.pop_front()
					elif (current.shape.Type == "wait"):
						iteration += 1
						threshold = current.shape.Var1
						wait()
						if (iteration == 2):
							iteration = 0
							threshold = 0.05
							current = activeAttack.pop_front()
							pass
	if current == null:
		isactive = false
	pass
	
func CartesianFull(atk = current):
	for i in range(-atk.shape.Var1/2, atk.shape.Var1/2 + 1):
		if atk.shape.AimingPosition == "Partner":
			var newBullet = atk.bullet.Create(get_parent(), get_parent().position.direction_to(corePartnerVars.position))
			newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
		elif atk.shape.AimingPosition == "Player":
			var newBullet = atk.bullet.Create(get_parent(), get_parent().position.direction_to(corePlayerVars.position))
			newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
		elif atk.shape.var3 != Vector2.ZERO:
			var newBullet = atk.bullet.Create(get_parent(), atk.shape.var3)
			newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
		else:
			var newBullet = atk.bullet.Create(get_parent(), Vector2.DOWN)
			newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
	pass

func CartesianIter(atk = current):
	var i = iteration - atk.shape.Var1 /2
	if atk.shape.AimingPosition == "Partner":
		var newBullet = atk.bullet.Create(get_parent(), get_parent().position.direction_to(corePartnerVars.position))
		newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
	elif atk.shape.AimingPosition == "Player":
		var newBullet = atk.bullet.Create(get_parent(), get_parent().position.direction_to(corePlayerVars.position))
		newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
	elif atk.shape.var3 != Vector2.ZERO:
		var newBullet = atk.bullet.Create(get_parent(), atk.shape.var3)
		newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
	else:
		var newBullet = atk.bullet.Create(get_parent(), Vector2.DOWN)
		newBullet.position = Vector2(get_parent().position.x -i * atk.shape.var2 * atk.shape.var2, get_parent().position.y - mathHandler.execute([i])*atk.shape.var2)
	pass
	
func wait():
	pass
