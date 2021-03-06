extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()
var playerMove = false
var delayframe = 0
var footstepsplaying = false

var is_drinking = false
var in_cutscene: bool = false

var message_direction = "right"


func _ready():
	Events.player = self
	Events.connect("player_collided_with_pickup", self, "on_pickup")
	CutScenes.collected_paintings == 0

func _physics_process(delta):
	if !in_cutscene && !is_drinking:
		get_input()
	
		if !is_drinking:
			if playerMove == true:
				velocity = move_and_slide(velocity)
				check_animation()
				Events.emit_signal("player_moved",self)
			check_player_move()
	
	drink_sound_check()

func get_input():
	velocity = Vector2()
	if delayframe == 10:
		if Input.is_action_pressed('right'):
			velocity.x += 1
			$PlayerRig.set_flip(1)
			playerMove = true
		if Input.is_action_pressed('left'):
			velocity.x -= 1
			$PlayerRig.set_flip(0)
			playerMove = true
		if Input.is_action_pressed('up'):
			velocity.y -= 1
			playerMove = true
		if Input.is_action_pressed('down'):
			velocity.y += 1
			playerMove = true
		velocity = velocity.normalized() * speed
#		if Input.is_action_just_pressed("ui_accept"):
#			playerMove = false
#			drink_animation()
#			set_timer()

func check_animation():
	$PlayerRig.update_animation("run")
	if footstepsplaying == false:
		$Footsteps.play()
		footstepsplaying = true

func check_player_move():
	if delayframe == 10:
		if velocity.x == 0 and velocity.y == 0:
			idle_animation()
	else:
		delayframe +=1

func idle_animation():
	$PlayerRig.update_animation("idle")
	$Footsteps.stop()
	playerMove = false
	footstepsplaying = false

func drink_animation():
	$PlayerRig.update_animation("drink")
	$Footsteps.stop()
	is_drinking = true
	footstepsplaying = false

func set_timer():
	$DrinkTimer.wait_time = 0.9
	$DrinkTimer.start()


func _on_DrinkTimer_timeout():
	is_drinking = false

func drink_sound_check():
	if is_drinking == true:
		if $DrinkTimer.time_left < 0.6 and $DrinkTimer.time_left > 0.59:
			$DrinkTimer/Drinking.play()
	if $DrinkTimer.time_left < 0.5:
			$DrinkTimer/Drinking.stop()

func on_pickup(object):
	if object.type == "booze":
		drink_animation()
		set_timer()

func play_cutscene(id):
	in_cutscene = true
	idle_animation()
	CutScenes.play_scene(id)
	get_next_message()

func get_next_message():
	var message = CutScenes.get_next_message()
	if message != "":
		var TextMessage = preload("res://Scenes/TextMessage/TextMessage.tscn").instance()
		if message_direction == "left":
			message_direction = "right"
		else:
			message_direction = "left"
		TextMessage.showText(message, message_direction)
		add_child(TextMessage)
	else:
		if CutScenes.collected_paintings < 3:
			in_cutscene = false
		else:
			get_tree().change_scene("res://Scenes/Screens/Ending Scene.tscn")
