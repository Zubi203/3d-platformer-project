extends Camera3D

@export var shake_intensity: float = 3.0
@export var shake_falloff: float = 5.0
var current_intensity: float

func _ready() -> void:
	EventBus.OnHealthUpdate.connect(_screen_shake)

func _process(delta: float) -> void:
	current_intensity = lerpf(current_intensity, 0, delta * shake_falloff)
	h_offset = randf_range(-current_intensity, current_intensity)
	v_offset = randf_range(-current_intensity, current_intensity)

func _screen_shake(_health: int) -> void:
	current_intensity = shake_intensity
