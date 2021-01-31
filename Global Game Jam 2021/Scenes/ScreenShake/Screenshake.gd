extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0

onready var camera = get_parent()


func _ready():
	Events.screenshake = self
	#start(0,250,1)
	pass


func start(duration,frequency,_amplitude):
	self.amplitude = _amplitude
	$Frequency.wait_time = 1 / float(frequency)
	if duration > 0:
		$Duration.wait_time = duration
		$Duration.start()
	$Frequency.start()
	new_shake()


func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()


func reset():
	$ShakeTween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()


func _on_Frequency_timeout():
	new_shake()


func _on_Duration_timeout():
	reset()
	$Frequency.stop()
