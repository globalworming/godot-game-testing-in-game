extends RigidBody2D
class_name OnHitTestSuccessBlock

@export var health = 0
var emitted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func on_ball_collision(_node: Node, _force: float):
	if !emitted:
		emitted = true
		TestStatus.test_success.emit()

