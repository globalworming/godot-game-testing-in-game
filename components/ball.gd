extends RigidBody2D

func _ready():
	body_entered.connect(_on_body_entered)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_body_entered(body: Node):
	if (body.is_in_group("block")):
		print("collide: " + body.name)
		body._ball_collision(self)
		

