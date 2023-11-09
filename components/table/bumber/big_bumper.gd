extends Node2D

func _on_body_entered(body: Node) -> void:
	print(body.name)
	var angle = global_position.angle_to(body.global_position)
	$RigidBody2D.apply_central_impulse(Vector2.from_angle(angle - PI/2).normalized() * 3000)
	pass # Replace with function body.
