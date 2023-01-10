extends Control

func _ready():
	$btn_Play.connect("pressed", self, "Play")
	$btn_Options.connect("pressed", self, "Options")
	$btn_Quit.connect("pressed", self, "Quit")
	
	$btn_Play.grab_focus()
	
func Play():
	get_tree().change_scene("res://Scenes/Menu/Play.tscn")
	pass
	
func Options():
	get_tree().change_scene("res://Scenes/Menu/Options.tscn")
	pass
	
func Quit():
	get_tree().quit()
	pass



