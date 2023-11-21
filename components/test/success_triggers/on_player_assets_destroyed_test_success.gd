extends Node2D

@export var player_assets_to_destroy: int


func _process(_delta: float) -> void:
	if Statistics.player_assets_destroyed >= player_assets_to_destroy:
		TestStatus.test_success.emit()
	pass
