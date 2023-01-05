extends Control

func _ready():
	$btn_New_Game.connect("pressed", self, "New_Game")
	$btn_Load_Game.connect("pressed", self, "Load_Game")
	$btn_Back.connect("pressed", self,"Back")
	pass 
	

func New_Game():
	pass
	
func Load_Game():
	pass
	
func Back():
	get_tree().change_scene("res://Scenes/Menu/Main.tscn")
	pass

