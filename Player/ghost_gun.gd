extends Sprite2D

var can_fire = true
var bullet = preload("res://Player/ghost_bullet.tscn")
@onready var bullet_position: Marker2D = $BulletPosition


func _ready() -> void:
	set_as_top_level(true)
	

func _physics_process(_delta: float) -> void:
	position.x = lerp(position.x, get_parent().position.x + 5, 0.5)
	position.y = lerp(position.y, get_parent().position.y + 5, 0.5)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)

	
	
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = bullet_position.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		await(get_tree().create_timer(0.15)).timeout
		can_fire = true
