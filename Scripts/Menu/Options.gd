extends Control

var can_select = true
var select_timer = 5

var master_selected = false
var music_selected = false
var effects_selected = false

var res_id
var resolution = false
var full_id
var fullscreen = false

var sp_pause = false
var sp_use = false

var ready = true
var ready_timer = 5
	
func _ready():
	
	$ctrl_Video/btn_Resolution.add_item("800 X 600",0)
	$ctrl_Video/btn_Resolution.add_item("1920 X 1080",1)
	
	$ctrl_Video/btn_Fullscreen.add_item("Fullscreen", 0)
	$ctrl_Video/btn_Fullscreen.add_item("Windowed", 1)
	
	res_id = $ctrl_Video/btn_Resolution.get_selected_id()
	full_id = $ctrl_Video/btn_Fullscreen.get_selected_id()
	
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
	$ctrl_Audio/btn_Effects_Mute.connect("pressed", self, "Mute_Effects")
	$ctrl_Audio/sldr_Effects.connect("value_changed", self, "Effects_Volume")
	
	$ctrl_Controls/btn_Keyboard.connect("pressed", self, "Keyboard")
	$ctrl_Controls/btn_Controller.connect("pressed", self, "Controller")
	
	$ctrl_Controls/Keyboard/btn_Use.connect("pressed", self, "Use_Button")
	$ctrl_Controls/Keyboard/btn_Pause.connect("pressed", self, "Pause_Button")
	$ctrl_Controls/Controller/btn_Use.connect("pressed", self, "Use_Button")
	$ctrl_Controls/Controller/btn_Pause.connect("pressed", self, "Pause_Button")
	
	$ctrl_Video/btn_Resolution.connect("pressed", self, "res_pressed")
	$ctrl_Video/btn_Fullscreen.connect("pressed", self, "full_pressed")
	
	if(Options.res_width == 800 and Options.res_height == 600):
		$ctrl_Video/btn_Resolution.select(0)
	if(Options.res_width == 1920 and Options.res_height == 1080):
		$ctrl_Video/btn_Resolution.select(1)
	if(Options.fullscreen == true):
		$ctrl_Video/btn_Resolution.select(0)
	if(Options.fullscreen == false):
		$ctrl_Video/btn_Resolution.select(1)
		
	$btn_Video.grab_focus()
		
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
	
	if(Options.Master_Mute == true):
		$ctrl_Audio/sldr_Master.set_modulate(Color(1,1,1,0.1))
	elif(Options.Master_Mute == false):
		$ctrl_Audio/sldr_Master.set_modulate(Color(1,1,1,1))
		
	if(Options.Music_Mute == true):
		$ctrl_Audio/sldr_Music.set_modulate(Color(1,1,1,0.1))
	elif(Options.Music_Mute == false):
		$ctrl_Audio/sldr_Music.set_modulate(Color(1,1,1,1))
	
	if(Options.Effects_Mute == true):
		$ctrl_Audio/sldr_Effects.set_modulate(Color(1,1,1,0.1))
	elif(Options.Effects_Mute == false):
		$ctrl_Audio/sldr_Effects.set_modulate(Color(1,1,1,1))
		
	controller_text()
		
	pass
	
func _process(delta):
	
	if(select_timer > 0):
		select_timer -= 1
		can_select = false
	else:
		can_select = true
		if(fullscreen == false):
			$ctrl_Video/btn_Fullscreen.disabled = false
		if(resolution == false):
			$ctrl_Video/btn_Resolution.disabled = false
	
	if(ready_timer > 0):
		ready_timer -= 1
		ready = true
	else:
		ready = false
		
	if($ctrl_Audio/sldr_Master.has_focus()):
		
		if(Input.is_action_just_pressed("ui_accept")):
			if(master_selected == false):
				master_selected = true
			elif(master_selected == true):
				master_selected = false
		if(master_selected == true):
			if(Input.is_action_pressed("ui_left")):
				$ctrl_Audio/sldr_Master.set_value($ctrl_Audio/sldr_Master.get.value() - 20)
				Master_Volume($ctrl_Audio/sldr_Master.get_value())
			if(Input.is_action_pressed("ui_right")):
				$ctrl_Audio/sldr_Master.set_value($ctrl_Audio/sldr_Master.get.value() + 20)
				Master_Volume($ctrl_Audio/sldr_Master.get_value())
		elif(master_selected == false):
			if(Input.is_action_pressed("ui_left")):
				$ctrl_Audio/sldr_Master.release_focus()
				$ctrl_Audio/btn_Master_Mute.grab_focus()
	elif(!$ctrl_Audio/sldr_Master.has_focus()):
		master_selected = false
		
	if($ctrl_Audio/sldr_Music.has_focus()):
		
		if(Input.is_action_just_pressed("ui_accept")):
			if(music_selected == false):
				music_selected = true
			elif(music_selected == true):
				music_selected = false
				
		if(music_selected == true):
			if(Input.is_action_pressed("ui_left")):
				$ctrl_Audio/sldr_Music.set_value($ctrl_Audio/sldr_Music.value() - 20)
				Music_Volume($ctrl_Audio/sldr_Master.get_value())
			if(Input.is_action_pressed("ui_right")):
				$ctrl_Audio/sldr_Music.set_value($ctrl_Audio/sldr_Music.value() + 20)
				Music_Volume($ctrl_Audio/sldr_Music.get_value())
		elif(music_selected == false):
			if(Input.is_action_pressed("ui_left")):
				$ctrl_Audio/sldr_Music.release_focus()
				$ctrl_Audio/btn_Music_Mute.grab_focus()
	elif(!$ctrl_Audio/sldr_Music.has_focus()):
		music_selected = false
			
	if($ctrl_Audio/sldr_Effects.has_focus()):
		
		if(Input.is_action_just_pressed("ui_accept")):
			if(effects_selected == false):
				effects_selected = true
			elif(effects_selected == true):
				effects_selected = false
		if(effects_selected == true):
			if(Input.is_action_pressed("ui_left")):
				$ctrl_Audio/sldr_Effects.set_value($ctrl_Audio/sldr_Effects.get.value() - 20)
				Effects_Volume($ctrl_Audio/sldr_Effects.get_value())
			if(Input.is_action_pressed("ui_right")):
				$ctrl_Audio/sldr_Effects.set_value($ctrl_Audio/sldr_Effects.get.value() + 20)
				Effects_Volume($ctrl_Audio/sldr_Effects.get_value())
		elif(effects_selected == false):
			if(Input.is_action_pressed("ui_left")):
				$ctrl_Audio/sldr_Effects.release_focus()
				$ctrl_Audio/btn_Effects_Mute_Mute.grab_focus()
	elif(!$ctrl_Audio/sldr_Effects.has_focus()):
		effects_selected = false
			
	if(resolution == true):
		res_change()
		
	if(fullscreen == true):
		full_change()
	pass
	
func _input(event):
	
	if(event is InputEventKey):
		if(sp_use == true):
			Options.key_use = event.scancode
			sp_use = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			controller_text()
			
		if(sp_pause == true):
			Options.key_pause = event.scancode
			sp_pause = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			controller_text()
			
	if(event is InputEventJoypadButton):
		if(Input.is_action_just_pressed("ui_accept")):
			if(fullscreen == true and can_select == true):
				$ctrl_Video/btn_Fullscreen.select(full_id)
				Fullscreen(full_id)
				fullscreen = false
				can_select = false
				select_timer = 5
				$ctrl_Video/btn_Fullscreen.get_popup().hide()
				
			if(resolution == true and can_select == true):
				$ctrl_Video/btn_Resolution.select(full_id)
				Resolution(full_id)
				resolution = false
				can_select = false
				select_timer = 5
				$ctrl_Video/btn_Resolution.get_popup().hide()
		
		if(Input.is_action_just_pressed("ui_cancel")):
			if(fullscreen == true):
				fullscreen = false
				can_select = false
				select_timer = 5
			
			if(resolution == true):
				resolution = false
				can_select = false
				select_timer = 5
		
		if(sp_use == true):
			Options.con_use_pad = true
			Options.con_use = event.get_button_index()
			sp_use = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			Options.controller()
			controller_text()
			
		if(sp_pause == true):
			Options.con_pause_pad = true
			Options.con_pause = event.get_button_index()
			sp_pause = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			Options.controller()
			controller_text()
			
		pass
	
	if(event is InputEventJoypadMotion):
		if(sp_use == true):
			Options.con_use_pad = false
			Options.con_use_axis = event.get_axis()
			sp_use = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			Options.controller()
			controller_text()
			
		if(sp_pause == true):
			Options.con_pause_pad = false
			Options.con_pause_axis = event.get_axis()
			sp_pause = false
			select_timer = 5
			can_select = false
			$ctrl_Controls/Key.hide()
			Options.controller()
			controller_text()
			
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
	
	res_id = $ctrl_Video/btn_Resolution.get_selected_id()
	full_id = $ctrl_Video/btn_Fullscreen.get_selected_id()
	
	resolution = false
	can_select = false
	select_timer = 5
	
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
	
	res_id = $ctrl_Video/btn_Resolution.get_selected_id()
	full_id = $ctrl_Video/btn_Fullscreen.get_selected_id()
	
	fullscreen = false
	can_select = false
	select_timer = 5
	
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
	if(ready == false):
		if(Options.Master_Mute == false):
			Options.Master_Mute = true
			$ctrl_Audio/sldr_Master.set_modulate(Color(1,1,1,0.1))
		elif(Options.Master_Mute == true):
			Options.Master_Mute = false
			$ctrl_Audio/sldr_Master.set_modulate(Color(1,1,1,1))
	Options.choose_music()
	Options.save_game()
	pass

func Master_Volume(value):
	if(ready == false):
		if(Options.Master_Mute == true):
			Options.Master_Mute = false
			$ctrl_Audio/sldr_Master.set_modulate(Color(1,1,1,1))
	Options.Master_Volume = $ctrl_Audio/sldr_Master.get_value()
	Options.save_game()
	pass
	
func Mute_Music():
	if(ready == false):
		if(Options.Music_Mute == false):
			Options.Music_Mute = true
			$ctrl_Audio/sldr_Music.set_modulate(Color(1,1,1,0.1))
		elif(Options.Music_Mute == true):
			Options.Music_Mute = false
			$ctrl_Audio/sldr_Music.set_modulate(Color(1,1,1,1))
	Options.choose_music()
	Options.save_game()	
	pass

func Music_Volume(value):
	if(ready == false):
		if(Options.Music_Mute == true):
			Options.Music_Mute == false
			$ctrl_Audio/sldr_Music.set_modulate(Color(1,1,1,1))
	Options.Music_Volume = $ctrl_Audio/sldr_Music.get_value()
	Options.save_game()
	pass
	
func Mute_Effects():
	if(ready == false):
		if(Options.Effects_Mute == false):
			Options.Effects_Mute = true
			$ctrl_Audio/sldr_Effects.set_modulate(Color(1,1,1,0.1))
		elif(Options.Effects_Mute == true):
			Options.Effects_Mute = false
			$ctrl_Audio/sldr_Effects.set_modulate(Color(1,1,1,1))
	Options.choose_music()
	Options.save_game()	
	pass

func Effects_Volume(value):
	if(ready == false):
		if(Options.Effects_Mute == true):
			Options.Effects_Mute = false
			$ctrl_Audio/sldr_Effects.set_modulate(Color(1,1,1,1))
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

func controller_text():
	if($ctrl_Controls/Keyboard.is_visible()):
		$ctrl_Controls/Keyboard/lbl_Use.set_text(OS.get_scancode_string(Options.key_use))
		$ctrl_Controls/Keyboard/lbl_Pause.set_text(OS.get_scancode_string(Options.key_pause))
		
	if($ctrl_Controls/Controller.is_visible()):
		$ctrl_Controls/Controller/spr_Use.set_texture(Options.con_use_image)
		$ctrl_Controls/Controller/spr_Pause.set_texture(Options.con_pause_image)
	pass
	
func Keyboard():
	$ctrl_Controls/Keyboard.show()
	$ctrl_Controls/Controller.hide()
	pass
	
func Controller():
	$ctrl_Controls/Keyboard.hide()
	$ctrl_Controls/Controller.show()
	Options.controller()
	pass
	
func res_pressed():
	if(resolution == false):
		if(can_select == true):
			resolution = true
			can_select = false
			select_timer = 5
			if($ctrl_Video/btn_Resolution.disabled == false):
				$ctrl_Video/btn_Resolution.disabled = true
	elif(resolution == true):
		if(can_select == true):
			resolution = false
			can_select = false
			select_timer = 5
			if($ctrl_Video/btn_Resolution.disabled == false):
				$ctrl_Video/btn_Resolution.disabled = true
	
	pass
	
func res_change():
	if(Input.is_action_just_pressed("ui_down")):
		res_id += 1
		if(res_id > 1):
			res_id = 0
	elif(Input.is_action_just_pressed("ui_up")):
		res_id -= 1
		if(res_id < 0):
			res_id = 1
	if(res_id == 0):
		$ctrl_Video/btn_Resolution.get_popup().set_item_checked(0,true)
		$ctrl_Video/btn_Resolution.get_popup().set_item_checked(1,false)
	elif(res_id == 1):
		$ctrl_Video/btn_Resolution.get_popup().set_item_checked(0,false)
		$ctrl_Video/btn_Resolution.get_popup().set_item_checked(1,true)
	pass
	
func full_pressed():
	if(fullscreen == false):
		if(can_select == true):
			fullscreen = true
			can_select = false
			select_timer = 5
			if($ctrl_Video/btn_Fullscreen.disabled == false):
				$ctrl_Video/btn_Fullscreen.disabled = true
	elif(fullscreen == true):
		if(can_select == true):
			fullscreen = false
			can_select = false
			select_timer = 5
			if($ctrl_Video/btn_Fullscreen.disabled == false):
				$ctrl_Video/btn_Fullscreenn.disabled = true
	pass
	
func full_change():
	if(Input.is_action_just_pressed("ui_down")):
		full_id += 1
		if(full_id > 1):
			full_id = 0
	elif(Input.is_action_just_pressed("ui_up")):
		full_id -= 1
		if(full_id < 0):
			full_id = 1
	if(full_id == 0):
		$ctrl_Video/btn_Fullscreen.get_popup().set_item_checked(0,true)
		$ctrl_Video/btn_Fullscreen.get_popup().set_item_checked(1,false)
	elif(full_id == 1):
		$ctrl_Video/btn_Fullscreen.get_popup().set_item_checked(0,false)
		$ctrl_Video/btn_Fullscreen.get_popup().set_item_checked(1,true)
	pass
