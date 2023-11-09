extends Node2D

@export var experience_to_collect = 500


func _process(_delta: float) -> void:
	if Statistics.experience_collected >= experience_to_collect:
		TestStatus.test_success.emit()
	pass
