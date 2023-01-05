extends Control

func _ready():
	$btn_Video.connect("pressed", self, "Video")
	$btn_Audio.connect("pressed", self, "Audio")
	$btn_Controls.connect("pressed", self, "Controls")	
	$btn_Back.connect("pressed", self, "Back")
	
func Video():
	pass

func Audio():
	pass
	
func Controls():
	pass
	
func Back():
	get_tree().change_scene("res://Scenes/Menu/Main.tscn")
	pass
