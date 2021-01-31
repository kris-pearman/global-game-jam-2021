extends Sprite

onready var tween_out_music = get_node("Tween")
onready var active_stream = $TitleIntro
export var transition_dur = 0.5
export var transition_type = 1
var cur_vol = 0

var selection = 0
var can_select = true
var active = false

func _ready():
	$TitleIntro.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if can_select == true:
		if event.is_action_pressed('up'):
			change_selection('up')
			$UISelect.play()
		if event.is_action_pressed('down'):
			change_selection('down')
			$UISelect.play()	
		if event.is_action_pressed('ui_accept'):
			$UIConfirm.play()
			fade_out(active_stream)
			can_select = false
			active = true
			
			

func _process(delta):
	updatecursor()
	if active == true:
		#color[3] += 0.01
		$ColorRect.color[3] += delta / 2
		
	
	
func change_selection(direction):
	if direction == 'up':
		selection += 1
	if direction == 'down':
		selection -= 1
	if selection < 0 :
		selection = 1
	if selection > 1 :
		selection = 0

func updatecursor():
	if selection == 0:
		position = Vector2(-550,-550)
	if selection == 1:
		position = Vector2(-550,-350)

func activate_selection():
	
	print('select')
	if selection == 0:
		get_tree().change_scene("res://Sprites/Intro Text/Intro 1.tscn")
	if selection == 1:
		get_tree().quit()
		

func _on_UIConfirm_finished():
	activate_selection()
	

func _on_TitleIntro_finished():
	cur_vol = $TitleIntro.volume_db
	$TitleIntro/TitleLoop.play()
	$TitleIntro/TitleLoop.volume_db = cur_vol
	active_stream = $TitleIntro/TitleLoop

func fade_out(stream):
#turns volume down over time
	tween_out_music.interpolate_property(stream, "volume_db", -7, -80, transition_dur, transition_type, Tween.EASE_IN, 0)
	tween_out_music.start()
