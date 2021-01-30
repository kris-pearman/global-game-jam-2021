extends Sprite

var selection = 0
var can_select = true

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
			can_select = false
			
			

func _process(delta):
	updatecursor()
	
	
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
		position = Vector2(330,350)
	if selection == 1:
		position = Vector2(330,450)

func activate_selection():
	
	print('select')
	if selection == 0:
		get_tree().change_scene("res://Scenes/Game.tscn")
	if selection == 1:
		get_tree().quit()
		


func _on_UIConfirm_finished():
	activate_selection()
	
