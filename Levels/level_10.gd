extends Node2D
@onready var game_over: CanvasLayer = $GameOver
@onready var skeleton: Player = $Skeleton
@onready var shooter: AnimatedSprite2D = $Shooter
@onready var ghost_boss: CharacterBody2D = $GhostBoss
@onready var shooter_image: AnimatedSprite2D = $ShooterImage

func _ready() -> void:
	ghost_boss.process_mode = Node.PROCESS_MODE_DISABLED
	shooter.process_mode = Node.PROCESS_MODE_DISABLED
	Music.stop()


func _on_skeleton_health_depleted() -> void:
	game_over.visible = true
	get_tree().paused = true
	skeleton.queue_free()


func _on_ghost_boss_boss_health_depleted() -> void:
	shooter.queue_free()
	BossFight.stop()
	shooter_image.queue_free()


func _on_chest_boss_ready() -> void:
	BossFight.play()
	ghost_boss.process_mode =Node.PROCESS_MODE_INHERIT
	%ShooterStarter.start()


func _on_shooter_starter_timeout() -> void:
	if shooter:
		shooter.process_mode = Node.PROCESS_MODE_INHERIT
