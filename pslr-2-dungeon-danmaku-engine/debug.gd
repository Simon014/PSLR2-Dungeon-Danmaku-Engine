extends Node2D

func _process(delta: float) -> void:
	print(delta)
	print(Engine.get_frames_per_second())
	pass
