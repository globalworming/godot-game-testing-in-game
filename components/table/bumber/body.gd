extends RigidBody2D

func on_ball_collision(ball: RigidBody2D, _force: float):
	$bump.play()
	var direction = global_position.direction_to(ball.global_position)
	apply_central_impulse(direction.normalized() * 5000)
	Experience.gain(10)
