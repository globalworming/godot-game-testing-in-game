extends RigidBody2D


func on_ball_collision(_ball: RigidBody2D):
	apply_central_impulse(Vector2.from_angle(self.global_rotation).normalized() * 3000)

