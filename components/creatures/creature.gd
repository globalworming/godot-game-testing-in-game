extends Node2D


@onready var body = $body
@onready var collider = $body/collision
@onready var squasher = $body/squash_area/CollisionShape2D
@export_range(0.0, 1000.0) var mass: float = 1.0
@export var health: float = 20.0
var squashed = false

func _on_ball_in_vicinity(ball: RigidBody2D) -> void:
	var ball_mass = ball.mass
	var my_mass = body.mass
	#print("""
	#my mass %f
	#ball mass %f
	#""" % [my_mass, ball_mass])
	var am_i_sqashable = ball_mass * 5 > my_mass
	if am_i_sqashable: 
		collider.set_deferred("disabled", true)
		squasher.set_deferred("disabled", false)
	else:
		collider.set_deferred("disabled", false)
		squasher.set_deferred("disabled", true)


		
func squash():
	if squashed: pass
	squashed = true
	$body/Puddle.visible = true
	$body/Creature.visible = false
	body.set_deferred("freeze", true)
	collider.set_deferred("disabled", true)
	squasher.set_deferred("disabled", true)
	Statistics.creatures_squashed += 1
	

func _process(_delta: float) -> void:
	if health <= 0:
		squash()
