extends CharacterBody3D

@export var move_speed: float = 5.0
@export var acceleration: float = 5.0
@export var braking: float = 3.0
@export var jump_force: float = 10.0
@export var gravity: float = 5.0
@export var health: int = 3

@export var audio_stream_player: AudioStreamPlayer3D
var coin_sfx: AudioStream = preload("res://Audio/coin.wav")
var damage_sfx: AudioStream = preload("res://Audio/take_damage.wav")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var move_input: Vector2 = Input.get_vector("move_right", "move_left", "move_backward", "move_forward")
	var move_direction: Vector3 = Vector3(move_input.x, 0, move_input.y)
	if move_direction:
		velocity.x = lerpf(velocity.x, move_direction.x * move_speed, delta * acceleration)
		velocity.z = lerpf(velocity.z, move_direction.z * move_speed, delta * acceleration)
	else:
		velocity.x = lerpf(velocity.x, 0.0, delta * braking)
		velocity.z = lerpf(velocity.z, 0.0, delta * braking)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	
	move_and_slide()

func _process(_delta: float) -> void:
	if global_position.y < -5:
		game_over()


func take_damage(damage_amount: int) -> void:
	health -= damage_amount
	_play_sound(damage_sfx)
	EventBus.OnHealthUpdate.emit(health)
	if health <= 0:
		game_over.call_deferred()

func increase_score(score_gain: int) -> void:
	PlayerStats.score += score_gain
	_play_sound(coin_sfx)
	EventBus.OnScoreUpdate.emit(PlayerStats.score)

func game_over() -> void:
	get_tree().reload_current_scene()

func _play_sound(sound: AudioStream) -> void:
	if audio_stream_player:
		audio_stream_player.stream = sound
		audio_stream_player.play()
