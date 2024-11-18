extends Node2D
@onready var game_over: CanvasLayer = $GameOver
@onready var skeleton: Player = $Skeleton
@onready var pause_menu: Control = $CanvasLayer2/PauseMenu

func _ready() -> void:
	pause_menu.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_skeleton_health_depleted() -> void:
	game_over.visible = true
	get_tree().paused = true
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	skeleton.queue_free()
