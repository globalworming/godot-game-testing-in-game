extends Node2D

@export var enabled = true
var ammo: RigidBody2D
var timer: Timer
@onready var angles = $angles
@onready var selected_angle = floori($angles.get_child_count() / 2.0)
var angle: Node2D

func _process(_delta: float) -> void:
	if !enabled: return
	if !ammo: get_ammo()
	if ammo:
		count_down()
		if !angle:
			angle = $angles.get_child(floori($angles.get_child_count() / 2.0))
		angle.get_node("./Polygon2D").color = Color(0.6, 0.2, 0.2)

func get_ammo():
	for body in $Area2D.get_overlapping_bodies():
			if !body.is_in_group("ball"): return
			if !(body is RigidBody2D): return
			if (body.global_position.distance_to(global_position) < 8):
				body.global_position = global_position
				$PinJoint2D.set_node_b(body.get_path())
				ammo = body
		
func count_down():
	if (!timer):
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.start(2)
		timer.timeout.connect(fire)
	$TextureProgressBar.value = (2 - timer.time_left) * 100

func fire():
	$PinJoint2D.set_node_b($PinJoint2D.get_path())
	var aim_angle = global_position.direction_to(angle.global_position)
	ammo.apply_central_impulse(aim_angle.normalized() * 10000)
	$TextureProgressBar.value = 0
	enabled = false
	ammo = null
	remove_child(timer)
	timer = null
	angle.get_node("./Polygon2D").color = Color(0.25, 0.25, 0.25)
	await get_tree().create_timer(0.2).timeout
	enabled = true

func _input(event: InputEvent) -> void:
	aim(event)
	
func aim(event: InputEvent):
	if !ammo: return
	if event.is_action_pressed("move_left"):
		var previous = angle
		selected_angle = max(0, selected_angle - 1)
		angle = $angles.get_child(selected_angle)
		previous.get_node("./Polygon2D").color = Color(0.25, 0.25, 0.25)
		angle.get_node("./Polygon2D").color = Color(0.6, 0.2, 0.2)
		
	if event.is_action_pressed("move_right"):
		var previous = angle
		selected_angle = min($angles.get_child_count() - 1, selected_angle + 1)
		angle = $angles.get_child(selected_angle)
		previous.get_node("./Polygon2D").color = Color(0.25, 0.25, 0.25)
		angle.get_node("./Polygon2D").color = Color(0.6, 0.2, 0.2)
