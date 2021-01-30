extends Label

func _ready():
	var font: DynamicFont = preload("res://Assets/Fonts/font.tres")
	add_font_override("font", font)
