extends NinePatchRect

const player_distance_right: Vector2 = Vector2(40, -170)
const player_distance_left: Vector2 = Vector2(-450, -170)
const color_invisible: Color = Color(0, 0, 0, 0)

var timer: Timer

var direction: String = ""

func _ready():
	set_direction(direction)
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(3)
	timer.connect("timeout", self, "hide")
	add_child(timer)
	timer.start()

func set_direction(direction):
	match direction:
		"left":
			rect_position = player_distance_left
		"right":
			rect_position = player_distance_right

func showText(text, direction = ""):
	$Label.text = text
	set_direction(direction)

func hide():
	#May seem redundant. Leaving hide function in case we want to make bubbles fade before disappearing
	get_parent().call_deferred("get_next_message")
	queue_free()
