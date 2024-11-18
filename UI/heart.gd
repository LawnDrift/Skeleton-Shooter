extends Node2D
var stats = PlayerStats

func _on_area_2d_body_entered(body: Node2D) -> void:
	stats.health += 1
	queue_free()
