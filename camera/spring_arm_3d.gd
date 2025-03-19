extends SpringArm3D

var player: CharacterBody3D
@onready var camera: Camera3D = $Camera3D

func _ready() -> void:
	camera.add_to_group("camera-main")

func _process(delta: float) -> void:
	if(player != null):
		position = player.position + (Vector3(0,10,10))
	else:
		player = get_tree().get_first_node_in_group("player-1")
