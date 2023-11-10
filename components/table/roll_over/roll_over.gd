extends Node2D

@export var enabled: bool = false

func _ready() -> void:
	$indicator.color = Color(0.1, 0.7, 0.7) if enabled else Color( 0.2, 0.6, 0,6)


func switch(body: Node2D):
	if enabled: return
	if !body.is_in_group("ball"): return
	enabled = !enabled
	$indicator.color = Color(1, 0.2, 0.2) if enabled else Color( 0.5, 0.1, 0,1)
