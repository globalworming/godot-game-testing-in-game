extends Node2D

var acting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !$rail_gun.ammo: return
	if acting: return
	acting = true
	await get_tree().create_timer(0.5).timeout
	SimulateInput.tap("move_right")
	await get_tree().create_timer(0.3).timeout
	SimulateInput.tap("move_left")
	await get_tree().create_timer(0.1).timeout
	SimulateInput.tap("move_left")
	await get_tree().create_timer(0.1).timeout
	SimulateInput.tap("move_left")
