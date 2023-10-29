extends RigidBody2D
class_name Block

@export var health = 0
var emitted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group(self.name)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _ball_collision(_node: Node):
	if !emitted:
		emitted = true
		TestStatus.test_success.emit()

