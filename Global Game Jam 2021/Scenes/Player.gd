extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()
var playerMove = false
var delayframe = 0
var footstepsplaying = false
var haltOthers = false

var in_cutscene: bool = false
var message_direction = "right"


func _ready():
	Events.player = self


func get_input():
	velocity = Vector2()
	if delayframe == 10:
		if haltOthers == false:
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
			if Input.is_action_pressed("ui_accept"):
				drink_animation()
				set_timer()


func _physics_process(delta):

	if !in_cutscene:
		get_input()
		velocity = move_and_slide(velocity)
		check_collision()
		check_animation()
		check_player_move()
		drink_sound_check()
	
	if playerMove == true:
		Events.emit_signal("player_moved",self)


func check_collision():
	for i in get_slide_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.collider.name)


func check_animation():
	if haltOthers == false:
		if playerMove == true:
			$PlayerRig.update_animation("run")
			if footstepsplaying == false:
				$Footsteps.play()
				footstepsplaying = true

func check_player_move():
	if haltOthers == false:
		if delayframe == 10:
			if velocity.x == 0 and velocity.y == 0:
				$PlayerRig.update_animation("idle")
				$Footsteps.stop()
				playerMove = false
				footstepsplaying = false
		else:
			delayframe +=1



func drink_animation():
	$PlayerRig.update_animation("drink")
	footstepsplaying = false
	$Footsteps.stop()

func set_timer():
	$DrinkTimer.start()
	haltOthers = true
	footstepsplaying = false


func _on_DrinkTimer_timeout():
	haltOthers = false
	$DrinkTimer.wait_time = 0.9

func drink_sound_check():
	if haltOthers == true:
		if $DrinkTimer.time_left < 0.6 and $DrinkTimer.time_left > 0.59:
			$DrinkTimer/Drinking.play()
	if $DrinkTimer.time_left < 0.5:
			$DrinkTimer/Drinking.stop()
	


func play_cutscene(id):
	in_cutscene = true
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
		in_cutscene = false

