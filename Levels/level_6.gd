extends Node2D
@onready var game_over: CanvasLayer = $GameOver
@onready var skeleton: Player = $World/Skeleton


func _on_skeleton_health_depleted() -> void:
	game_over.visible = true
	get_tree().paused = true
	skeleton.queue_free()
