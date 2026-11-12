extends Control

var HPBar: ColorRect
var dodges: RichTextLabel

func _ready() -> void:
	HPBar = $HPBar/ColorRect
	dodges = $dodges



func _on_u_iupdate_timeout() -> void:
	HPBar.scale.x = corePlayerVars.Health / corePlayerVars.maxhealth
	dodges.text = str(coreDungeonStats.dodges)
	if HPBar.scale.x < 0:
		HPBar.scale.x = 0
	pass # Replace with function body.
