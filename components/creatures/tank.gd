extends RigidBody2D

var target: RigidBody2D
var fire_rate: int
var interval: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = exp(Statistics.current_minute) * 1000
	($Health as Health).set_value(health, health)
	
	fire_rate = floor(exp(Statistics.current_minute) * 40)
	interval = floor(100.0 / fire_rate)
	$progress.max_value = interval * 100
	$progress.visible = false
	$targeting.timeout.connect(fire)
	pass # Replace with function body.

func _process(_delta: float) -> void:
	$progress.value = (interval - $targeting.time_left) * 100

func aquire_target():
	var new_targets = get_node("/root").find_children("*", "RigidBody2D", true, false).filter(
		func (it: RigidBody2D): 
			#print(it.name)
			return it.is_in_group("destructable_player_asset")).filter(
		func (it: RigidBody2D): 
			#print(it.name)
			return (it.get_node("Health") as Health).current_value > 0)
	if (new_targets.size() == 0): return
	new_targets.sort_custom(func (a: Node2D, b: Node2D): return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position))
	target = new_targets[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (!target): 
		aquire_target()
		return
	if (target.get_node("Health") as Health).current_value <= 0:
		target = null
		$targeting.stop()		
		return
		
	# rotate until looking at
	Movement.rotate_to(delta, target, self, 1000000, 3)
	if (!Movement.looking_at(target, self, deg_to_rad(5))): return
	
	#advance to target
	if (target.global_position.distance_squared_to(global_position) > 500000):
		$targeting.stop()
		linear_damp = 1
		Movement.move_forward(delta, self, 10000)
		return 
	linear_damp = 10
	if ($targeting.is_stopped()):
		$progress.visible = true
		$targeting.start(interval)
	
func fire():
	if !target: return
	$shot_particle.emitting = true
	$impact_particle.global_position = target.global_position  + Vector2(0, -20)
	$impact_particle.global_rotation = 0
	$impact_particle.restart()
	$shot.playing = true
	var target_health = target.get_node_or_null("Health") as Health
	if (target_health): target_health.damage(15)
	pass


#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
#	print("_integrate_forces: tank speed %s" %  state.linear_velocity.length())


func on_ball_collision(_ball: RigidBody2D, force: float): 
	#print("damage %s" % force)
	($Health as Health).damage(int(force))
