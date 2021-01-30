extends Node2D


onready var anim_state_machine = $AnimationTree.get("parameters/playback")



func _ready():
	# Start the Idle animation upon loading the game
	anim_state_machine.call_deferred("start", "idle")


func update_animation(anim_name: String) -> void:
	# Call this to play certain animations
	anim_state_machine.travel(anim_name)


func set_flip(is_flipped: bool) -> void:
	# For flipping the sprite
	if is_flipped:
		self.scale.x = -0.6
	else:
		self.scale.x = 0.6


