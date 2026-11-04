extends Resource
class_name Shape
#stores attack mode, and shape configuration.
@export_enum("Directional", "Cartesian", "mouse") var Type: String = "Directional"
@export_enum("Full", "Iterative") var Mode: String = "Full"
@export var MathFunction: String = "x"
@export var Var1: int = 4
@export var var2: int = 1
