extends RigidBody2D

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("ball")
	pass

func _physics_process(delta: float) -> void:
	if (linear_velocity.length() > linear_velocity.limit_length(5000).length()):
		set_linear_velocity(linear_velocity.limit_length(5000))

func _on_body_entered(body: Node):
	#print("collide with %s" % body.name)
	if body.has_method("on_ball_collision"):
		body.on_ball_collision(self)

func move_to_z0():
	collision_layer = 1
	collision_mask = 1
	z_index = 0
	
func move_to_z1():
	collision_layer = 4
	collision_mask = 4
	z_index = 4
	
