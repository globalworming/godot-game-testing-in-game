class_name DestructablePlayerAsset extends Node2D

var is_destroyed = false;
@onready var indicator = $indicator

func _ready() -> void:
	get_parent().add_to_group("destructable_player_asset")

# Called when the node enters the scene tree for the first time.
func destroy() -> void:
	if is_destroyed: return
	Statistics.player_assets_destroyed += 1
	is_destroyed = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	indicator.emitting = is_destroyed
