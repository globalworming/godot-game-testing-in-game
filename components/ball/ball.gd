extends RigidBody2D

var trail: Line2D

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("ball")
	trail = Line2D.new()
	trail.width = 48
	trail.antialiased = true
	trail.gradient = Gradient.new()
	trail.gradient.colors = PackedColorArray([Color(0, 0, 1, .01), Color( .1, .7, 1, .04)])
	get_parent().call_deferred("add_child", trail)
	get_parent().call_deferred("move_child", trail, 0)
	pass

func _process(_delta: float) -> void:
	trail.add_point(global_position)

func _physics_process(_delta: float) -> void:
	if (linear_velocity.length() > linear_velocity.limit_length(5000).length()):
		set_linear_velocity(linear_velocity.limit_length(5000))


var previous_linear_velocities : Array[Vector2] = [Vector2.ZERO, Vector2.ZERO, Vector2.ZERO]

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#print("_integrate_forces: ball speed %s" %  state.linear_velocity.length())
	previous_linear_velocities.pop_front()
	previous_linear_velocities.push_back(state.linear_velocity)

func _on_body_entered(body: Node):
	#print("collide with %s" % body.name)
	if body.has_method("on_ball_collision"):
	#	print("_on_body_entered: ball speed after collition %s" %  linear_velocity.length())
		var collision_force = mass * previous_linear_velocities.map(func (it): 
			return (it - linear_velocity).length()
		).max()
		#print("force: %s" % collision_force)
		body.on_ball_collision(self, collision_force)

func move_to_z0():
	collision_layer = 1
	collision_mask = 1
	z_index = 0
	
func move_to_z1():
	collision_layer = 4
	collision_mask = 4
	z_index = 4
	
