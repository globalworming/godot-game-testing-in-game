extends RigidBody2D

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group(name)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
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
	
