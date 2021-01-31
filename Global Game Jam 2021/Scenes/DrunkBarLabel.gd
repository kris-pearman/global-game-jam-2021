extends Label


func _ready():
	var font: DynamicFont = preload("res://Assets/Fonts/barfont.tres")
	add_font_override("font", font)
	add_color_override("font_color", Color(0.35, 0.32, 0.38, 1))
