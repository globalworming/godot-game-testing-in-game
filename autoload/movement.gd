extends Node

## rotate rigid body to to face target by applying torque
## should be called in [method RigidBody2D._physics_process]
func rotate_to(delta: float, target: Node2D, body: RigidBody2D, force: int, accuracy_degrees: float): 
	var difference = rotation_difference(target, body)
	
	if (abs(difference) < deg_to_rad(accuracy_degrees) ): 
		# stop rotation when on target
		body.lock_rotation = true
	# but after that allow rotation again
	#body.angular_damp = 30
	body.lock_rotation = false
		
	if (difference > 0):
		body.apply_torque(force * body.mass * delta) 
	if (difference < 0):
		body.apply_torque(-force * body.mass * delta) 


func rotation_difference(target: Node2D, body: Node2D) -> float:
	var target_rotation = body.global_position.angle_to_point(target.global_position)
	return fmod(target_rotation - body.rotation, 2 * PI)


func move_forward(delta: float, body: RigidBody2D,force: int, max_speed: int = 500): 
	if (body.linear_velocity.length() <= max_speed):
		var direction = Vector2.from_angle(body.rotation).normalized()
		body.apply_central_force(direction * delta * body.mass * force) 
	else: body.linear_velocity = body.linear_velocity.normalized() * max_speed

func move_towards(delta: float, target: Node2D, body: RigidBody2D, force: int, max_speed: int = 500): 
	if (body.linear_velocity.length() <= max_speed):
		var direction = Vector2.from_angle(body.global_position.angle_to_point(target.global_position)).normalized()
		body.apply_central_force(direction  * delta * body.mass * force) 
	else: body.linear_velocity = body.linear_velocity.normalized() * max_speed

func looking_at(target: Node2D, body: Node2D, accuracy: float):
	return abs(Movement.rotation_difference(target, body)) <= accuracy
