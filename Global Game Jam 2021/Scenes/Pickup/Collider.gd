extends Area2D



func _on_Collider_body_entered(body):
	Events.emit_signal("player_collided_with_pickup","Drink",1)
