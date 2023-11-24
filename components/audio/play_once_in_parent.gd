extends Node2D

func play():
	var dup = get_child(0).duplicate()
	var body = get_parent()
	while !(body is RigidBody2D):
		body = body.get_parent()
	body.get_parent().add_child(dup)
	dup.global_position = body.global_position
	dup.finished.connect(dup.queue_free)	
	dup.play()
