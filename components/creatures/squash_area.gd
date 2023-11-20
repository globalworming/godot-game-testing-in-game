extends Area2D

func _on_body_entered(body: Node2D) -> void:
	#print("entered", body.name)
	if (body.is_in_group("ball") || body.name == "paddle"):
		(get_parent().get_node("Squashable") as Squashable).squash()
