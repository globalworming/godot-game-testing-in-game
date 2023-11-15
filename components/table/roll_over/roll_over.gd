extends Node2D

@export var enabled: bool = false

func _ready() -> void:
	apply_color()


func switch(body: Node2D):
#	if enabled: return
	if !body.is_in_group("ball"): return
	enabled = !enabled
	apply_color()
	
func apply_color():
	$indicator.color = Color.DEEP_PINK if enabled else Color.CORNFLOWER_BLUE
	
