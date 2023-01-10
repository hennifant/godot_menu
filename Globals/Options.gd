extends Control

# Temporary

const SAVE_PATH = "res://settings.json"

var settings = {}
var play_Music = 1
var play_Effects = 1
var new_choice = 1
var song
var menu = true
var paused = false
var pause_menu = false
var con_use_image
var con_pause_image

# Saved

var Master_Volume = 2000
var Music_Volume = 2000
var Effects_Volume = 2000
var Master_Mute = false
var Music_Mute = false
var Effects_Mute = false
var res_width = 1920
var res_height = 1080
var fullscreen = false

var key_use = 32
var key_pause = 16777217

var con_use = 0
var con_use_pad = true
var con_use_axis = 0

var con_pause = 0
var con_pause_pad = true
var con_pause_axis = 0

func _ready():
	load_game()
	choose_music()
	resolution()
	pass 
	
func _process(delta):
	
	if(!$Music.is_playing()):
		choose_music()
	
	if(Master_Volume > 0 and Music_Volume > 0):
		play_Music = int((Master_Volume / 2000) * (Music_Volume / 2000) * 2000)
	else:
		play_Music = 1
		
	if(Master_Mute == true or Music_Mute == true):
		play_Music = 1
		
	if(Master_Volume > 0 and Effects_Volume > 0):
		play_Effects = int((Master_Volume / 2000) * (Effects_Volume / 2000) * 2000)
	else:
		play_Effects = 1
	if(Master_Mute == true or Effects_Mute == true):
		play_Effects = 1
		
	$Music.set_max_distance(play_Music)
	
	pass

func choose_music():
	if(menu == true):
		menu_music()
	else:
		game_music()
	pass
	
func menu_music():
	
	randomize()
	
	new_choice = int(rand_range(1,5))
	
	match new_choice:
		1:
			song = load("res://Audio/Menu/Essence.mp3")
		2:
			song = load("res://Audio/Menu/Fallout.mp3")
		3:
			song = load("res://Audio/Menu/Horizons.mp3")
		4:
			song = load("res://Audio/Menu/Pulsefire.mp3")
		5:
			song = load("res://Audio/Menu/Skyrim.mp3")
			
	$Music.set_stream(song)
	$Music.play(0.0)
	
	pass
	
func game_music():
	
	randomize()
	
	new_choice = int(rand_range(1,5))
	
	match new_choice:
		1:
			song = load("res://Audio/Game/Alive.mp3")
		2:
			song = load("res://Audio/Game/Asleep.mp3")
		3:
			song = load("res://Audio/Game/Dangerous.mp3")
		4:
			song = load("res://Audio/Game/Save.mp3")
		5:
			song = load("res://Audio/Game/Shot.mp3")
			
	$Music.set_stream(song)
	$Music.play(0.0)
	
	pass
	
func resolution():
	
	if(fullscreen == true):
		OS.set_window_fullscreen(false)
		OS.set_window_fullscreen(true)
	elif(fullscreen == false):
		OS.set_window_fullscreen(true)
		OS.set_window_fullscreen(false)
		OS.set_window_position(Vector2(0,0))
	
	ProjectSettings.set_setting("display/window/size/width", res_width)
	ProjectSettings.set_setting("display/window/size/height", res_height)
	OS.set_window_size(Vector2(res_width, res_height))
	
	if(fullscreen == true):
		OS.set_window_fullscreen(false)
		OS.set_window_fullscreen(true)
	elif(fullscreen == false):
		OS.set_window_fullscreen(true)
		OS.set_window_fullscreen(false)
		OS.set_window_position(Vector2(0,0))
		
	pass
	
func save_game():
	
	var settings = {
		resolution = {
			width = res_width,
			height = res_height	
		},
		fullscreen = fullscreen,
		Master_Volume = Master_Volume,
		Master_Mute = Master_Mute,
		Music_Volume = Music_Volume,
		Music_Mute = Music_Mute,
		Effects_Volume = Effects_Volume,
		Effects_Mute = Effects_Mute,
		
		key_use = key_use,
		key_pause = key_pause,
		con_use = con_use,
		con_use_pad = con_use_pad,
		con_use_axis = con_use_axis,
		con_pause = con_pause,
		con_pause_pad = con_pause_pad,
		con_pause_axis = con_pause_axis
		
	}
	
	var save_file = File.new()
	save_file.open(SAVE_PATH,File.WRITE)
	save_file.store_line(to_json(settings))
	save_file.close()
	
	pass
	
func load_game():
	
	var save_file = File.new()
	if(not save_file.file_exists(SAVE_PATH)):
		return
	save_file.open(SAVE_PATH, File.READ)
	
	var data = {}
	data = parse_json(save_file.get_as_text())
	
	Master_Volume = data['Master_Volume']
	Music_Volume = data['Music_Volume']
	Effects_Volume = data['Effects_Volume']
	Master_Mute = data['Master_Mute']
	Music_Mute = data['Music_Mute']
	Effects_Mute = data['Effects_Mute']
	res_width = data['resolution']['width']
	res_height = data['resolution']['height']
	fullscreen = data['fullscreen']
	key_use = data['key_use']
	key_pause = data['key_pause']
	con_use = data['con_use']
	con_use_pad = data['con_use_pad']
	con_use_axis = data['con_use_axis']
	con_pause = data['con_pause']
	con_pause_pad = data['con_pause_pad']
	con_pause_axis = data['con_pause_axis']
	
	pass

func controller():
	if(con_use_pad == true):
		if(con_use == 0):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_A.png")
		elif(con_use == 1):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_B.png")
		elif(con_use == 2):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_X.png")
		elif(con_use == 3):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Y.png")
		elif(con_use == 4):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_LB.png")
		elif(con_use == 5):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_RB.png")
		elif(con_use == 6):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_LT.png")
		elif(con_use == 7):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_RT.png")
		elif(con_use == 8):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Left_Stick.png")
		elif(con_use == 9):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Right_Stick.png")
		elif(con_use == 10):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Square.png")
		elif(con_use == 11):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Home.png")
		elif(con_use == 12):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Up.png")
		elif(con_use == 13):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Down.png")
		elif(con_use == 14):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Left.png")
		elif(con_use == 15):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Right.png")
		
	elif(con_use_pad == false):
		if(con_use == 0):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Left_Stick.png")
		elif(con_use == 1):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Left_Stick.png")
		elif(con_use == 2):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Right_Stick.png")
		elif(con_use == 3):
			con_use_image = load("res://Textures/UI/Controls/Switch/Switch_Right_Stick.png")
	if(con_pause_pad == true):
		if(con_pause == 0):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_A.png")
		elif(con_pause == 1):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_B.png")
		elif(con_pause == 2):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_X.png")
		elif(con_pause == 3):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Y.png")
		elif(con_pause == 4):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_LB.png")
		elif(con_pause == 5):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_RB.png")
		elif(con_pause == 6):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_LT.png")
		elif(con_pause == 7):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_RT.png")
		elif(con_pause == 8):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Left_Stick.png")
		elif(con_pause == 9):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Right_Stick.png")
		elif(con_pause == 10):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Square.png")
		elif(con_pause == 11):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Home.png")
		elif(con_pause == 12):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Up.png")
		elif(con_pause == 13):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Down.png")
		elif(con_pause == 14):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Left.png")
		elif(con_pause == 15):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Dpad_Right.png")
			
	elif(con_pause_pad == false):
		if(con_pause == 0):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Left_Stick.png")
		elif(con_pause == 1):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Left_Stick.png")
		elif(con_pause == 2):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Right_Stick.png")
		elif(con_pause == 3):
			con_pause_image = load("res://Textures/UI/Controls/Switch/Switch_Right_Stick.png")
	
		
	pass
