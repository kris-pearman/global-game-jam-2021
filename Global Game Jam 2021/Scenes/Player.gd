extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

var in_cutscene: bool = false
var message_direction = "right"

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !in_cutscene:
		get_input()
		velocity = move_and_slide(velocity)
		check_collision()

func check_collision():
	for i in get_slide_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.collider.name)

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
