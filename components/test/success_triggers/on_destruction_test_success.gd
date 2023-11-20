extends Node2D

@export_node_path("Path2D") var destructable = ^"../flipper/paddle"
var health: Health

func _ready() -> void:
	var _destructable = get_node(destructable)
	if !_destructable.has_node("Health"): 
		push_error("connect component with health!")
	health = _destructable.get_node("Health")

func _process(_delta: float) -> void:
	if health.current_value <= 0:
		TestStatus.test_success.emit()
