extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if PlayerStats.health != PlayerStats.max_health:
		PlayerStats.health += 1
		queue_free()
