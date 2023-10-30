extends RigidBody2D

func _ready():
	body_entered.connect(_on_body_entered)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _on_body_entered(body: Node):
	if body.has_method("on_ball_collision"):
		body.on_ball_collision(self)
