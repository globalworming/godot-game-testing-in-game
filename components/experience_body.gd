extends RigidBody2D


	
func on_ball_collision(_ball: RigidBody2D): 
	Statistics.experience_collected += 100
	var parent = get_parent()
	parent.get_parent().remove_child(parent)
