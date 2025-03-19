extends RigidBody3D

@export var weapon_name: String
@export var current_ammo: int
@export var reserve_ammo: int
var dropped: bool = true

func _process(delta: float) -> void:
	if dropped:
		apply_impulse(transform.basis.z,-transform.basis.z * 10)
		dropped = false
