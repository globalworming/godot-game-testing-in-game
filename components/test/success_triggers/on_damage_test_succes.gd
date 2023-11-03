extends Node2D

@export var damage_to_deal: int = 20

func _process(_delta: float) -> void:
	if Statistics.damage_dealt >= damage_to_deal:
		TestStatus.test_success.emit()
	pass
