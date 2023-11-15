extends RigidBody2D

func on_ball_collision(_ball: RigidBody2D): 
	if !visible: return
	visible = false
	collision_layer = 0
	Statistics.experience_collected += 100
	$ding.play()
	await $ding.finished
	get_parent().remove_child(self)
