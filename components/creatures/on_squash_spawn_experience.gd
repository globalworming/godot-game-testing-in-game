extends Node2D

var experience = preload("res://components/experience.tscn")

func _ready() -> void:
	if get_parent().has_signal("squashed"):
		get_parent().squashed.connect(spawn_experience)

func spawn_experience():
	var _experience = experience.instantiate()
	get_parent().get_parent().call_deferred("add_child", _experience)
	_experience.global_position = global_position
	_experience.apply_central_impulse(Vector2.from_angle(randf_range(0, 2 * PI)) * 10)
	
