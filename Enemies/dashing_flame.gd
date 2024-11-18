extends CharacterBody2D

@onready var player: CharacterBody2D = get_node("/root/Level10/Skeleton") 
@onready var dashing_bat: CharacterBody2D = $"."
@onready var timer: Timer = $Timer

func _ready() -> void:
	set_physics_process(false)
	if Player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 170
		move_and_slide()

func _physics_process(delta):
	move_and_slide()


func _on_timer_timeout() -> void:
	set_physics_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
