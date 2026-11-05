extends Resource
class_name Shape
#stores attack mode, and shape configuration.
@export_enum("Directional", "Cartesian", "mouse", "wait") var Type: String = "Directional"
@export_enum("Full", "Iterative") var Mode: String = "Full"
@export var MathFunction: String = "x"
@export var Var1: float = 4
@export var var2: float = 1
@export var var3: Vector2
@export_enum("None","Player","Partner") var AimingPosition = "None"
