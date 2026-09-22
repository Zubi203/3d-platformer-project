extends Area3D

@export var move_direction: Vector3
@export var move_speed: float = 5.0
@export var spin_speed: float = 900.0

@export var model: MeshInstance3D

@onready var start_position: Vector3 = global_position
@onready var target_position: Vector3 = start_position + move_direction

func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, delta * move_speed)
	
	if global_position == start_position:
		target_position = start_position + move_direction
	elif global_position == start_position + move_direction:
		target_position = start_position

func _process(delta: float) -> void:
	if model:
		model.rotation.z += deg_to_rad(spin_speed) * delta

func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	body.take_damage(1)
