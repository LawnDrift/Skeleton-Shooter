
#This is chest2.gd
#Chest2.gd gives hearts to the player
#use only for that


extends StaticBody2D
@onready var sprite: Sprite2D = $Sprite2D
var is_in_area = false

func _ready() -> void:
	sprite.z_index = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_chest") and is_in_area == true:
		sprite.frame = 1
		spawn_healing_heart()
		spawn_healing_heart()
		print("hearts spawned")
		set_process(false)


func _on_chest_zone_body_entered(body: Node2D) -> void:
	is_in_area = true


func _on_chest_zone_body_exited(body: Node2D) -> void:
	is_in_area = false

func spawn_healing_heart():
	var new_healing_heart = preload("res://World/healing_heart.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_healing_heart.global_position = %PathFollow2D.global_position
	get_parent().add_child.call_deferred(new_healing_heart)
