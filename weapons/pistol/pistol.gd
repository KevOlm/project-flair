extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var spawn: RayCast3D = $RayCast3D
const bullet = preload("res://weapons/pistol/bullet_pistol.tscn")

func shoot():
	if !animation_player.is_playing() or animation_player.current_animation != "shoot":
		animation_player.play("shoot")
		var instance_b = bullet.instantiate()
		instance_b.global_position = spawn.global_position
		instance_b.transform.basis = spawn.global_transform.basis
		get_tree().current_scene.add_child(instance_b)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
