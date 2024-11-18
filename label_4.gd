extends Label

func _ready() -> void:
	$".".visible = false


func _on_player_detection_zone_body_entered(body: Node2D) -> void:
	$".".visible = true
