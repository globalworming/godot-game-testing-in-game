class_name Paddle extends RigidBody2D

@export var input_action: String = "move_left"
@export var speed: float = 10000
@export var left_flipper = true

var slime: float
var slime_decay = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group("destructable_player_asset")
	if $Health:
		$Health.set_value(100, 100)
	$slime_decay_delay.timeout.connect(func(): slime_decay = true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
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
	
	if event.is_action_pressed(input_action):
		$paddle_up.play()
		constant_torque = 0		
		add_constant_torque(10000 * max(100, speed - slime) * (-1 if left_flipper else 1))
	
	if event.is_action_released(input_action):
		$paddle_down.play()		
		constant_torque = 0
		add_constant_torque(10000 * max(100, speed - slime) * (1 if left_flipper else -1))
	
	#if left_flipper: 
	#	if (rotation_degrees > -30) && (rotation_degrees < -15):
	#		$extended_collision.disabled = false
	#	else:
	#		$extended_collision.disabled = true
	#else:
	#	if (rotation_degrees < 30) && (rotation_degrees > 15):
	#		$extended_collision.disabled = false
	#	else:
	#		$extended_collision.disabled = true
			
func _on_body_entered(body: Node):
	#print("collide with %s" % body.name)
	if body.has_method("on_paddle_collision"):
		body.on_paddle_collision(self)

func _process(delta: float) -> void:
	$Slime/progress.value = min(100, 100 * slime / speed)
	if (slime_decay): slime -= delta * speed / 10
	if (slime < 0): slime = 0; slime_decay = false
	
func increase_slime():
	slime = min(speed, slime + speed / 10)
	$slime_decay_delay.start(3)
	slime_decay = false
