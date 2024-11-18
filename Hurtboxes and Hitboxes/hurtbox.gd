extends Area2D
const HitEffect = preload("res://Effects/hit_effect.tscn")
const flameEffect = preload("res://Effects/flame_effect.tscn")

@export var invincible:bool = false
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration):
	self.invincible = true
	emit_signal("invincibility_started")
	timer.start(duration)


func create_hit_effect():
	var effect = HitEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func create_flame_effect():
	var effect = flameEffect.instantiate()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_timer_timeout() -> void:
	self.invincible = false
	emit_signal("invincibility_ended")


func _on_invincibility_started() -> void:
	collision_shape_2d.set_deferred("disabled", true)


func _on_invincibility_ended() -> void:
	collision_shape_2d.disabled = false
