extends CanvasLayer

func _ready() -> void:
	if $".".visible == true:
		Music.stop()
		BossFight.stop()

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(get_parent().scene_file_path)
	if PlayerStats.health <= 0:
		PlayerStats.health = 2
	Music.play()

func _on_button_2_pressed() -> void:
	get_tree().quit()
