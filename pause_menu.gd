extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("RESET")
	hide()

func _process(delta: float) -> void:
	testEsc()

func resume():
	get_tree().paused = false
	animation_player.play_backwards("blur")
	hide()

func pause():
	show()
	get_tree().paused = true
	animation_player.play("blur")

func testEsc():
	if Input.is_action_just_pressed("Esc") and get_tree().paused == false:
		pause()
	elif  Input.is_action_just_pressed("Esc") and get_tree().paused == true:
		resume()



func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	Music.play()
	if PlayerStats.health != PlayerStats.max_health:
		PlayerStats.health = PlayerStats.max_health


func _on_quit_pressed() -> void:
	get_tree().quit()
