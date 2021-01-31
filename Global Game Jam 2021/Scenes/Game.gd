extends Node

var soberVol = -55
var critVol = -65
var metervalue = 100
var critmeter = 100

func _input(event):
	if event.is_action_pressed('ui_cancel'):
		get_tree().change_scene("res://Scenes/Screens/Title.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Intro.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	convertMeterToVol()
	$"Sober Layer".volume_db = soberVol
	$"Critical Layer".volume_db = critVol
	check_drunk_audio()


func _on_Intro_finished():
	$Main.play()
	$"Sober Layer".play()
	$"Critical Layer".play()
	
func convertMeterToVol():
	var currentMeterValue = Events.drunk_meter.value
	currentMeterValue = (currentMeterValue-10) * -1
	var threshold = 8.4
	var track2Volume = getVolumeDb(currentMeterValue, false, threshold)
	var track3Volume = getTrack3VolumeDb(currentMeterValue, true, threshold)
	soberVol = track2Volume
	critVol = track3Volume

func getVolumeDb(meterValue, useModifier, threshold):
	#assumes meterValue = 0-10
	var lowerLimit = -50
	var upperLimit = -3
	var dbRange = upperLimit - lowerLimit

	var conversionFactor = float(dbRange)/float(10)
	var progress = (conversionFactor * meterValue)

	return  progress + lowerLimit

func getTrack3VolumeDb(meterValue, useModifier, threshold):
	var lowerLimit = -50
	var upperLimit = -2
	var dbRange = upperLimit - lowerLimit
	if meterValue < threshold:
		return lowerLimit

	var conversionFactor = float(dbRange)/float(10)
	var progress = (conversionFactor * meterValue)
	var normalisationFactor = float(meterValue - threshold) / float(10 - threshold)
	return  (progress * normalisationFactor) + lowerLimit
	
func check_drunk_audio():
	if Events.drunk_meter.value > 8.6:
		if !$Drunk.playing:
			$Drunk.play()
	else:
		$Drunk.stop()
