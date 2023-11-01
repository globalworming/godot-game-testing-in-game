extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Statistics.damage_dealt == 20:
		TestStatus.test_success.emit()
	pass
