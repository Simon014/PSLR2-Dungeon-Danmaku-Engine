extends Resource
class_name Shape
#stores attack mode, and shape configuration.
@export_enum("Directional", "Cartesian") var Type: String
@export_enum("Full", "Iterative") var Mode: String = "Full"
@export var MathFunction: String
@export var Var1: int
@export var var2: int
@export var CartesianPositionAim: Vector2 = Vector2.ZERO
