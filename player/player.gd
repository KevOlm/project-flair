extends CharacterBody3D

@onready var pistol: Node3D = $Weapon_Manager/Rig/pistol
@onready var shoot: Timer = $shoot
const SPEED = 10.0
const JUMP_VELOCITY = 4.5
var ray_origin = Vector3()
var ray_target = Vector3()
var camera: Camera3D
var shoot_state: bool = false

func _ready() -> void:
	shoot.stop()
	add_to_group("player-1")
	camera = get_tree().get_first_node_in_group("camera-main")

func _physics_process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	ray_origin = camera.project_ray_origin(mouse_position)
	ray_target = ray_origin + camera.project_ray_normal(mouse_position) * 500
	var ray_query = PhysicsRayQueryParameters3D.create(ray_origin,ray_target)
	
	ray_query.collide_with_bodies = true
	
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(ray_query)
	
	if (!result.is_empty()):
		look_at(Vector3(result.position.x,position.y,result.position.z))
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_action("shoot"):
		if event.is_pressed():
			shoot_state = true
			shoot.start(0.3)
			pistol.shoot()
		else:
			shoot_state = false
			shoot.stop()

func _on_shoot_timeout() -> void:
	if shoot_state:
		pistol.shoot()
