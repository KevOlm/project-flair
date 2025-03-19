extends Node3D

var current_weapon = null

var weapon_stack = []
var weapon_indicator = 0
var next_weapon: String

var weapon_list = {}

@export var _weapon_resource: Array[Weapon_Resource]
@export var start_weapons: Array[String]

func _ready() -> void:
	Initialize(start_weapons)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("weapon_up"):
		weapon_indicator = min(weapon_indicator+1,weapon_stack.size()-1)
		Exit(weapon_stack[weapon_indicator])
	
	if event.is_action_pressed("weapon_down"):
		weapon_indicator = min(weapon_indicator-1,0)
		Exit(weapon_stack[weapon_indicator])

func Initialize(_start_weapons:Array):
	for weapon in _weapon_resource:
		weapon_list[weapon.w_name] = weapon
	for i in _start_weapons:
		weapon_stack.push_back(i)
	current_weapon = weapon_list[weapon_stack[0]]
	Enter()

func Enter():
	pass

func Change_weapon(_w_name: String):
	current_weapon = weapon_list[_w_name]
	next_weapon = ""
	Enter()

func Exit(_next_weapon:String):
	if _next_weapon != current_weapon.w_name:
		Change_weapon(next_weapon)
