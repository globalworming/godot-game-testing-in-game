extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("entered to z0")
	if body.is_in_group("ball"):
		body.move_to_z0()	
	
