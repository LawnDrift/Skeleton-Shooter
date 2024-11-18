extends AnimatedSprite2D

var bullet = preload("res://red_bullet.tscn")
@onready var bullet_position: Marker2D = $bulletPosition
@onready var player_detection_zone: Area2D = $playerDetectionZone


func _ready() -> void:
	set_as_top_level(true)

func _physics_process(_delta: float) -> void:

	var player = player_detection_zone.player
	if player != null:
		var mouse_pos = player.global_position
		look_at(mouse_pos)

	
	


func spawn_bullet():
	var bullet_instance = bullet.instantiate()
	bullet_instance.rotation = rotation
	bullet_instance.global_position = bullet_position.global_position
	get_parent().add_child(bullet_instance)
	await(get_tree().create_timer(0.15)).timeout



func _on_timer_timeout() -> void:
	spawn_bullet()
