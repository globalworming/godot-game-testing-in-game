extends RigidBody2D

@export var input_action: String = "move_left"
@export var speed: float = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(input_action):
		constant_torque = 0		
		$collision_area.scale = Vector2(1, 3)
		add_constant_torque(-100000 * speed)
		pass
	
	if Input.is_action_just_released(input_action):
		constant_torque = 0
		$collision_area.scale = Vector2(1, 3)
		add_constant_torque(100000 * speed)
		pass
		
	$collision_area.scale = Vector2.ONE
