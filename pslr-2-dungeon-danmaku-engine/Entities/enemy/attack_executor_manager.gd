extends Node

var activeAttack: Attack = null
var activeFunc: String
var mathHandler = Expression.new()
var timer = 0
#iterative variables
var iteration = 0
var maxbullets

func _ready() -> void:
	pass
	
func ExecuteNewAttack(atk: Attack) -> void:
	if (atk == activeAttack or activeAttack != null):
		pass
	else:
		mathHandler.parse(atk.shape.MathFunction, ["x"])
		if (mathHandler.get_error_text() != "") :
			printerr("Inputted Math Function not valid !: " + mathHandler.get_error_text())
		else:
			activeAttack = atk
			activeFunc = activeAttack.shape.MathFunction
			maxbullets = activeAttack.shape.Var1 / 2
			iteration = -maxbullets
	pass

func _process(delta: float) -> void:
	#first, create a manual timer
	timer += delta
	if timer > 0.05:
		timer = 0
		#execute attack.
		if activeAttack == null:
			pass
		else:
			if (activeAttack.shape.Type == "Cartesian"):
				if (activeAttack.shape.Mode == "Full"):
					CartesianFull()
					activeAttack = null
				elif (maxbullets != iteration):
					CartesianIter()
					iteration += 1
				else:
					activeAttack = null
					iteration = 0
		
	pass
	
func CartesianFull(atk = activeAttack):
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

func CartesianIter(atk = activeAttack):
	var i = iteration
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
