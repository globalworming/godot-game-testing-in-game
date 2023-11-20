extends RigidBody2D

func on_ball_collision(_ball: RigidBody2D, _force: float):
	get_parent().switch()
	Experience.gain(10)
