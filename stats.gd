extends Node

@export var max_health = 1
var health = max_health:
	get:
		return health
	set(value):
		health = value
		emit_signal("health_changed", health)
		if health <= 0:
			emit_signal("no_health")

func set_max_health(value):
	max_health = value
	if health:
		self.health = min(health, max_health)
	emit_signal("max_health_changed", max_health)

func _ready() -> void:
	self.health = max_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)
