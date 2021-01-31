extends ProgressBar


const drunkenness_start:float = 0.5
const withdrawal_start:float = 0.3

var alcohol_increase: float = 0
var increase_step: float = 0.025

func _ready():
	Events.drunk_meter = self
	max_value = 10
	value = 8.9
	Events.connect("player_collided_with_pickup",self,"on_pickup")
	Events.connect("player_moved",self,"on_player_moved")


func on_pickup(object):
	alcohol_increase += object.value


func on_player_moved(player):
	value -= 0.002


func _process(delta):
	if alcohol_increase > increase_step:
		alcohol_increase -= increase_step
		value += increase_step
	elif alcohol_increase < -increase_step:
		alcohol_increase += increase_step
		value -= increase_step
	if ratio >= drunkenness_start:
		Events.drunk_effect.set_intensity(ratio - drunkenness_start)
	if ratio <= withdrawal_start:
		if $WithdrawalTimer.is_stopped():
			$WithdrawalTimer.start()
	else:
		if not $WithdrawalTimer.is_stopped():
			$WithdrawalTimer.stop()
	if value <= 0:
		start_game_over_timer()
	elif value >= max_value - 1:
		start_game_over_timer()


func start_game_over_timer():
	Events.emit_signal("game_over")
	var timer = Timer.new()
	timer.wait_time = 2
	timer.connect("timeout",self,"_on_game_over_timer_timeout") 
	add_child(timer)
	timer.start()
	# Stop player controls
	Events.player.in_cutscene = true


func _on_game_over_timer_timeout():
	get_tree().change_scene("res://Scenes/Screens/End.tscn")


func _on_WithdrawalTimer_timeout():
	print("shake")
	Events.screenshake.start(1,150,1.5)
