extends RigidBody2D

@onready var creature = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = creature.mass
	pass # Replace with function body.


func on_ball_collision(_ball: RigidBody2D): 
	var damage = 15
	Statistics.damage_dealt += min(creature.health, damage)
	creature.health -= damage
