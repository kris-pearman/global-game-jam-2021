extends Control

var target_intensity:float = 0


func _ready():
	Events.drunk_effect = self


func _process(delta):
	var current_intensity = $ColorRect.material.get("shader_param/intensity")
	var change:float = 0
	if current_intensity < target_intensity:
		change = 0.002
	elif current_intensity > target_intensity:
		change = -0.002
	$ColorRect.material.set("shader_param/intensity",current_intensity + change)


func set_intensity(value):
	target_intensity = value
	
