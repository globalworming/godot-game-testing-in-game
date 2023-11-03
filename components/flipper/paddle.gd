extends RigidBody2D

@export var input_action: String = "move_left"
@export var speed: float = 1000
@export var left_flipper = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if left_flipper: 
		if (rotation_degrees < -50):
			rotation_degrees = -50
		if (rotation_degrees > 5):
			rotation_degrees = 5
	else:
		if (rotation_degrees > 50):
			rotation_degrees = 50
		if (rotation_degrees < -5):
			rotation_degrees = -5
	
	if Input.is_action_just_pressed(input_action):
		constant_torque = 0		
		add_constant_torque(100000 * speed * (-1 if left_flipper else 1))
	
	if Input.is_action_just_released(input_action):
		constant_torque = 0
		add_constant_torque(100000 * speed * (1 if left_flipper else -1))
	
	if left_flipper: 
		if (rotation_degrees > -30) && (rotation_degrees < -15):
			$extended_collision.disabled = false
		else:
			$extended_collision.disabled = true
	else:
		if (rotation_degrees < 30) && (rotation_degrees > 15):
			$extended_collision.disabled = false
		else:
			$extended_collision.disabled = true
			
func _on_body_entered(body: Node):
	#print("collide with %s" % body.name)
	if body.has_method("on_paddle_collision"):
		body.on_paddle_collision(self)

