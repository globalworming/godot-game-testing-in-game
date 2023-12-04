extends Node2D

@onready var area: Area2D = get_node("../squash_area");

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "paddle"):
		(body as Paddle).increase_slime()
