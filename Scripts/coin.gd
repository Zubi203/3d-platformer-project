extends Area3D

@export var rotate_speed: float = 180
@export var bob_height: float = 2.0
@export var bob_speed: float = 2.0

@export var coin_mesh: MeshInstance3D

func _process(delta: float) -> void:
	if coin_mesh:
		_rotate_coin(delta)
		_coin_bob(delta)

func _rotate_coin(delta: float):
	coin_mesh.rotation.y += deg_to_rad(rotate_speed) * delta

func _coin_bob(_delta: float):
	var time = Time.get_unix_time_from_system()
	coin_mesh.position.y = -cos(time * bob_speed) * bob_height + abs(bob_height)

func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("Player"):
		return
	
	body.increase_score(1)
	queue_free()
