extends Control

var can_select = true
var select_timer = 5

var sp_pause = false
var sp_use = false
	
func _ready():
	$btn_Video.connect("pressed", self, "Video")
	$btn_Audio.connect("pressed", self, "Audio")
	$btn_Controls.connect("pressed", self, "Controls")	
	$btn_Back.connect("pressed", self, "Back")
	$ctrl_Video/btn_Resolution.connect("item_selected", self, "Resolution")
	$ctrl_Video/btn_Fullscreen.connect("item_selected", self, "Fullscreen")
	$ctrl_Audio/btn_Master_Mute.connect("pressed", self, "Mute_Master")
	$ctrl_Audio/sldr_Master.connect("value_changed", self, "Master_Volume")
	$ctrl_Audio/btn_Music_Mute.connect("pressed", self, "Mute_Music")
	$ctrl_Audio/sldr_Music.connect("value_changed", self, "Music_Volume")
	$ctrl_Audio/btn_Effects.connect("pressed", self, "Mute_Effects")
	$ctrl_Audio/sldr_Effects.connect("value_changed", self, "Effects_Volume")
	$ctrl_Controls/btn_Use.connect("pressed", self, "Use_Button")
	$ctrl_Controls/btn_Pause.connect("pressed", self, "Pause_Button")
	
	$ctrl_Video/btn_Resolution.add_item("800 X 600",0)
	$ctrl_Video/btn_Resolution.add_item("1920 X 1080",1)
	
	if(Options.res_width == 800 and Options.res_height == 600):
		$ctrl_Video/btn_Resolution.select(0)
	if(Options.res_width == 1920 and Options.res_height == 1080):
		$ctrl_Video/btn_Resolution.select(1)
		
	$ctrl_Video/btn_Fullscreen.add_item("Fullscreen", 0)
	$ctrl_Video/btn_Fullscreen.add_item("Windowed", 1)
	
	if(Options.fullscreen == true):
		$ctrl_Video/btn_Resolution.select(0)
	if(Options.fullscreen == false):
		$ctrl_Video/btn_Resolution.select(1)
		
	$ctrl_Audio/sldr_Master.set_value(Options.Master_Volume)
	$ctrl_Audio/sldr_Music.set_value(Options.Music_Volume)
	$ctrl_Audio/sldr_Effects.set_value(Options.Effects_Volume)
	
	$lbl_Name.set_size(Vector2(1024,60))
	$ctrl_Video.set_size(Vector2(1024,450))
	$ctrl_Video.set_position(Vector2(0,150))
	$ctrl_Audio.set_size(Vector2(1024,450))
	$ctrl_Audio.set_position(Vector2(0,150))
	$ctrl_Controls.set_size(Vector2(1024,450))
	$ctrl_Controls.set_position(Vector2(0,150))
	pass
	
func _process(delta):
	
	if(select_timer > 0):
		select_timer -= 1
		can_select = false
	else:
		can_select = true
		
	if($ctrl_Controls.is_visible()):
		$ctrl_Controls/lbl_Use.set_text(OS.get_scancode_string(Options.sp_use))
		$ctrl_Controls/lbl_Pause.set_text(OS.get_scancode_string(Options.sp_pause))
	pass
	
func _input(event):
	
	if(event is InputEventKey):
		if(sp_use == true):
			Options.sp_use = event.scancode
			sp_use = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			
	if(sp_pause == true):
			Options.sp_pause = event.scancode
			sp_pause = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
	pass
	
func Video():
	$ctrl_Video.show()
	$ctrl_Audio.hide()
	$ctrl_Controls.hide()
	pass

func Audio():
	$ctrl_Video.hide()
	$ctrl_Audio.show()
	$ctrl_Controls.hide()
	pass
	
func Controls():
	$ctrl_Video.hide()
	$ctrl_Audio.hide()
	$ctrl_Controls.show()
	pass
	
func Back():
	if(Options.paused == false):
		get_tree().change_scene("res://Scenes/Menu/Main.tscn")
	elif(Options.paused == true):
		Options.pause_menu = true
	pass

func Resolution(item):
	
	match item:
		0:
			Options.res_width = 800
			Options.res_height = 600
			Options.resolution()
			Options.save_game()
		1:
			Options.res_width = 1920
			Options.res_height = 1080
			Options.resolution()
			Options.save_game()
	pass
	
func Fullscreen(item):
	
	match item:
		0:
			Options.fullscreen = true
			Options.resolution()
			Options.save_game()
		1:
			Options.fullscreen = false
			Options.resolution()
			Options.save_game()	
pass
	
func Mute_Master():
	if(Options.Master_Mute == false):
		Options.Master_Mute = true
	if(Options.Master_Mute == true):
		Options.Master_Mute = false
	Options.choose_music()
	Options.save_game()
	pass

func Master_Volume(value):
	Options.Master_Volume = $ctrl_Audio/sldr_Master.get_value()
	Options.save_game()
	pass
	
func Mute_Music():
	if(Options.Music_Mute == false):
		Options.Music_Mute = true
	if(Options.Music_Mute == true):
		Options.Music_Mute = false
	Options.choose_music()
	Options.save_game()	
	pass

func Music_Volume(value):
	Options.Music_Volume = $ctrl_Audio/sldr_Music.get_value()
	Options.save_game()
	pass
	
func Mute_Effects():
	if(Options.Effects_Mute == false):
		Options.Effects_Mute = true
	if(Options.Effects_Mute == true):
		Options.Effects_Mute = false
	Options.choose_music()
	Options.save_game()	
	pass

func Effects_Volume(value):
	Options.Effects_Volume = $ctrl_Audio/sldr_Effects.get_value()
	Options.save_game()
	pass
	
func Use_Button():
	if(can_select == true):
		sp_use = true
		$ctrl_Controls/Key.show()
	pass
	
func Pause_Button():
	if(can_select == true):
		sp_pause = true
		$ctrl_Controls/Key.show()
	pass
