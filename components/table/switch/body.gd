extends RigidBody2D

func on_ball_collision(_ball: RigidBody2D): 
	get_parent().switch()
