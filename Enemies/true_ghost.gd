extends CharacterBody2D

const enemy_death_effect = preload("res://Effects/death_effect.tscn")

@onready var sprite: Sprite2D = $Sprite2D
@onready var stats: Node = $Stats
@onready var player_detection_zone: Area2D = $playerDetectionZone
@onready var hurt_box: Area2D = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer


@export var ACCELERATION = 300
@export var MAX_SPEED = 30
@export var FRICTION= 500

func _ready() -> void:
	pass

func _on_stats_no_health() -> void:
	queue_free()
	var enemy_death_effect = enemy_death_effect.instantiate()
	get_parent().add_child(enemy_death_effect)
	enemy_death_effect.global_position = global_position

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	var player = player_detection_zone.player 
	if player != null:
		accelerate_towards_point(player.global_position, delta)
	move_and_slide()

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0


func _on_player_detection_zone_body_entered(body: Node2D) -> void:
	animation_player.play("ghost_appearing")


func _on_player_detection_zone_body_exited(body: Node2D) -> void:
	animation_player.play("ghost_desappearing")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	hurt_box.create_hit_effect()
