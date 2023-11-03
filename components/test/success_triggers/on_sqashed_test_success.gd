extends Node2D

@export var to_squash = 5

func _process(_delta: float) -> void:
	if Statistics.creatures_squashed >= to_squash:
		TestStatus.test_success.emit()
