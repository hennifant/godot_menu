extends Control

var scene

func _ready():
	$Pause/btn_Resume.connect("pressed", self, "Resume")
	$Pause/btn_Load_Game.connect("pressed", self, "Load")
	$Pause/btn_Save_Game.connect("pressed", self, "Save")
	$Pause/btn_Options.connect("pressed", self, "Options")
	$Pause/btn_Quit.connect("pressed", self, "Quit")
	pass
	
	# temporary
	
	Options.paused = true
	$Pause/btn_Resume.grab_focus()
	pass

func _process(delta):
	
	if(Options.pause_menu == true):
		for node in get_tree().get_nodes_in_group("temporary"):
			node.queue_free()
		get_tree().root.get_children()[1].show()
		
		Options.pause_menu = false
	pass
	
func Resume():
	Options.paused = false
	$Pause.hide()
	pass
	
func Load():
	get_tree().root.get_children()[1].hide()
	scene = load("res://Scenes/Menu/Load.tscn").instance()
	get_tree().root.get_children()[0].add_child(scene)
	scene.add_to_group("temporary")
	pass

func Save():
	get_tree().root.get_children()[1].hide()
	scene = load("res://Scenes/Menu/Save.tscn").instance()
	get_tree().root.get_children()[0].add_child(scene)
	scene.add_to_group("temporary")
	pass
	
func Options():
	get_tree().root.get_children()[1].hide()
	scene = load("res://Scenes/Menu/Options.tscn").instance()
	get_tree().root.get_children()[0].add_child(scene)
	scene.add_to_group("temporary")
	pass
	

func Quit():
	get_tree().change_scene("res://Scenes/Menu/Main.tscn")
	pass

