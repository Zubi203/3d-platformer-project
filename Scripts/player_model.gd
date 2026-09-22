extends MeshInstance3D

@export var bob_height: float = 0.5
@export var bob_speed: float = 2.0
@export var rotate_speed: float = 5.0
var target_rotation: float = 0

@export var player: CharacterBody3D

func _process(delta: float) -> void:
	_bob_animation()
	_smooth_rotation(delta)

func _smooth_rotation(delta: float):
	if player:
		if player.velocity.x != 0 or player.velocity.z != 0:
			target_rotation = atan2(player.velocity.x, player.velocity.z)
			rotation.y = lerp_angle(rotation.y, target_rotation, delta * rotate_speed)

func _bob_animation():
	if player.velocity.length() > 1 and player.is_on_floor():
		var time = Time.get_unix_time_from_system()
		scale.y = 1 + sin(time * bob_speed) * bob_height
	else:
		scale.y = 1
