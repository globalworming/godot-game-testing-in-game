extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("ball")):
		var node = get_parent().get_parent()
		node.squash()
		pass # Replace with function body.
