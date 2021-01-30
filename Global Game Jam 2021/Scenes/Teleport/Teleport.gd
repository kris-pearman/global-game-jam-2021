extends Area2D

export var id: int #teleport id in the map, in case we have many teleports in a single map
export var to_map_id: int #map id to teleport to

func _ready():
	self.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	Events.emit_signal("player_teleported", to_map_id, id)
