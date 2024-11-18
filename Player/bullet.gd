extends Area2D

@export var SPEED = 200

func _ready() -> void:
	set_as_top_level(true)

func _process(delta: float) -> void:
	position += (Vector2.RIGHT * SPEED).rotated(rotation) * delta

func _physics_process(delta: float) -> void:
	await(get_tree().create_timer(0.01) ).timeout
	set_physics_process(false)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
