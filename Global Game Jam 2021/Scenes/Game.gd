extends Node

var soberVol = -55
var critVol = -65
var metervalue = 100
var critmeter = 100

func _input(event):
	if event.is_action_pressed('ui_cancel'):
		get_tree().change_scene("res://Scenes/Screens/End.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Intro.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$"Sober Layer".volume_db = soberVol
	$"Critical Layer".volume_db = critVol
	convertMeterToVol()
#	if Input.is_action_pressed('right'):
#		if metervalue < 100:
#			metervalue += 1
#		if critmeter < 100:
#			critmeter += 6.25
#	if Input.is_action_pressed('left'):
#		if metervalue > 0:
#			metervalue -= 1
#	$CanvasLayer/UI/MarginContainer/VBoxContainer/MarginContainer/DrunkBar.value = metervalue

	
func updateSoberAudio():
	soberVol = ((metervalue/2.5) * -1) - 5

func updateCriticalAudio():
	critVol = ((critmeter/6.25) * -1) - 5


func _on_Intro_finished():
	$Main.play()
	$"Sober Layer".play()
	$"Critical Layer".play()
	
func convertMeterToVol():
	var currentMeterValue = $CanvasLayer/UI/MarginContainer/VBoxContainer/MarginContainer/DrunkBar.value
	currentMeterValue = (currentMeterValue-100) * -1
	var threshold = 84
	var track2Volume = getVolumeDb(currentMeterValue, false, threshold)
	var track3Volume = getTrack3VolumeDb(currentMeterValue, true, threshold)
#	print(currentMeterValue)
	print("this is track 2 " + str(track2Volume))
	print("this is track 3 " + str(track3Volume))
	soberVol = track2Volume
	critVol = track2Volume

func getVolumeDb(meterValue, useModifier, threshold):
	#assumes meterValue = 0-100
	var lowerLimit = -40
	var upperLimit = -5
	var dbRange = upperLimit - lowerLimit

	var conversionFactor = float(dbRange)/float(100)
	var progress = (conversionFactor * meterValue)

	return  progress + lowerLimit

func getTrack3VolumeDb(meterValue, useModifier, threshold):
	var lowerLimit = -40
	var upperLimit = -5
	var dbRange = upperLimit - lowerLimit
	if meterValue < threshold:
		return lowerLimit

	var conversionFactor = float(dbRange)/float(100)
	var progress = (conversionFactor * meterValue)
	var normalisationFactor = float(meterValue - threshold) / float(100 - threshold)
	return  (progress * normalisationFactor) + lowerLimit

