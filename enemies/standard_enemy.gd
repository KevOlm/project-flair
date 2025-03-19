extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var accel:int = 5
var HP:int = 3

func _ready() -> void:
	add_to_group("enemy")

func update_target_loc(target_loc) -> void:
	navigation_agent_3d.set_target_position(target_loc)

func _physics_process(delta: float) -> void:
	var current_location = global_position
	var next_location = navigation_agent_3d.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	
	velocity = velocity.lerp(new_velocity,accel * delta)
	
	if HP < 1:
		queue_free()
	move_and_slide()
