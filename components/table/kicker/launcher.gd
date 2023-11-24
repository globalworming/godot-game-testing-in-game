extends RigidBody2D


func on_ball_collision(_ball: RigidBody2D, _force: float):
	$kick.play()
	apply_central_impulse(Vector2.from_angle(global_rotation).normalized() * 4000)
	Experience.gain(10)
