extends Control

const SAVE1_PATH = "res://save.json"
var save1 = {}
var save1_file = File.new()
const SAVE2_PATH = "res://save.json"
var save2 = {}
var save2_file = File.new()

func _ready():
	$btn_Save1.connect("pressed", self, "Save1")
	$btn_Save2.connect("pressed", self, "Save2")
	$btn_Back.connect("pressed", self, "Back")
	
	if(!save1_file.file_exists(SAVE1_PATH)):
		$btn_Save1.hide()
		
	if(!save2_file.file_exists(SAVE2_PATH)):
		$btn_Save2.hide()
	pass

func Save1():
	var save_file = File.new()
	if(not save_file.file_exists(SAVE1_PATH)):
		return
	save_file.open(SAVE1_PATH, File.READ)
	
	var data = {}
	data = parse_json(save_file.get_as_text())
	
	pass
	
func Save2():
	var save_file = File.new()
	if(not save_file.file_exists(SAVE2_PATH)):
		return
	save_file.open(SAVE2_PATH, File.READ)
	
	var data = {}
	data = parse_json(save_file.get_as_text())
	pass
	
func Back():
	if(Options.paused == false):
		get_tree().change_scene("res://Scenes/Menu/Main.tscn")
	elif(Options.paused == true):
		Options.pause_menu = true
	pass
