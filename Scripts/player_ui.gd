extends CanvasLayer

@export var score_label: Label
@export var health_container: HBoxContainer
var hearts: Array = []

func _ready() -> void:
	if health_container:
		hearts = health_container.get_children()
	
	EventBus.OnHealthUpdate.connect(_update_hearts)
	EventBus.OnScoreUpdate.connect(_update_score)

func _update_hearts(health: int) -> void:
	for i in len(hearts):
		hearts[i].visible = i < health

func _update_score(score: int) -> void:
	if score_label:
		score_label.text = "Score: " + str(score)
