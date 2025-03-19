extends Node3D

@onready var player: CharacterBody3D = $player

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	get_tree().call_group("enemy","update_target_loc",player.global_position)
