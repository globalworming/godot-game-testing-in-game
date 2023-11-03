extends RigidBody2D

@onready var creature = get_parent()
@onready var sprite = $Creature

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mass = creature.mass
	pass # Replace with function body.


func on_ball_collision(_ball: RigidBody2D): 
	var damage = 15
	Statistics.damage_dealt += min(creature.health, damage)
	creature.health -= damage

func on_paddle_collision(_paddle: RigidBody2D): 
	var damage = 10
	Statistics.damage_dealt += min(creature.health, damage)
	creature.health -= damage
