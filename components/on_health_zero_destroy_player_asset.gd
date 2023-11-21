extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = get_parent().get_node("Health") as Health
	health.zero.connect((get_parent().get_node("DestructablePlayerAsset") as DestructablePlayerAsset).destroy)
