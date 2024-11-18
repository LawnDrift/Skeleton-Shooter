extends CharacterBody2D
const enemy_death_effect = preload("res://Effects/death_effect.tscn")

@onready var sprite: Sprite2D = $Sprite2D
@onready var stats: Node = $Stats
@onready var player_detection_zone: Area2D = $playerDetectionZone
@onready var hurt_box: Area2D = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wander_controller: Node2D = $WanderController
@onready var spawn_flame_timer: Timer = $SpawnFlameTimer
@onready var spawn_true_ghost_timer: Timer = $SpawnTrueGhostTimer
@onready var hurtbox: Area2D = $Hurtbox
@onready var progress_bar: ProgressBar = $ProgressBar



@export var ACCELERATION = 300
@export var MAX_SPEED = 30
@export var FRICTION= 500

enum {
	IDLE,
	CHASE,
	SUMMON,
	FLAMES,
	HIDE,
	HIDING
}

var state = CHASE

func _ready() -> void:
	progress_bar.visible = false
	animation_player.play("appearing")

func _on_stats_no_health() -> void:
	queue_free()
	var enemy_death_effect = enemy_death_effect.instantiate()
	get_parent().add_child(enemy_death_effect)
	enemy_death_effect.global_position = global_position
	boss_health_depleted.emit()

func _process(delta: float) -> void:
	if state == SUMMON:
		spawn_true_ghost_timer.start()
		spawn_flame_timer.start()
		animation_player.play("appearing")
	elif state == FLAMES:
		animation_player.play("appearing")
		spawn_flame()
	elif state == HIDING:
		hurtbox.process_mode = Node.PROCESS_MODE_DISABLED



func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	
	match state:
		IDLE:
			hurt_box.process_mode = Node.PROCESS_MODE_INHERIT
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta )

			seek_player()
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([CHASE, HIDE, CHASE, FLAMES, SUMMON])
				
				player_detection_zone.process_mode = Node.PROCESS_MODE_INHERIT
				
				wander_controller.start_wander_timer(randf_range(1, 2))

		CHASE:
			hurt_box.process_mode = Node.PROCESS_MODE_INHERIT
			var player = player_detection_zone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([CHASE, HIDE, CHASE, FLAMES, SUMMON])
				
				player_detection_zone.process_mode = Node.PROCESS_MODE_DISABLED
				
				wander_controller.start_wander_timer(randf_range(1, 3))
				

		SUMMON:
			hurt_box.process_mode = Node.PROCESS_MODE_INHERIT
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([CHASE, HIDE, FLAMES, FLAMES, SUMMON])
				
				player_detection_zone.process_mode = Node.PROCESS_MODE_INHERIT
				
				wander_controller.start_wander_timer(randf_range(1, 3))
				
				accelerate_towards_point(wander_controller.target_position, delta)


			if global_position.distance_to(wander_controller.target_position) <= 4:
				state = pick_random_state([CHASE, HIDE, FLAMES, FLAMES, SUMMON])
				wander_controller.start_wander_timer(randf_range(1, 3))

		FLAMES:
			hurt_box.process_mode = Node.PROCESS_MODE_INHERIT
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([CHASE, HIDE, SUMMON, FLAMES, FLAMES, FLAMES])
				
				player_detection_zone.process_mode = Node.PROCESS_MODE_INHERIT
				
				wander_controller.start_wander_timer(randf_range(1, 3))
				
				accelerate_towards_point(wander_controller.target_position, delta)


			if global_position.distance_to(wander_controller.target_position) <= 4:
				state = pick_random_state([CHASE, HIDE, SUMMON, FLAMES, FLAMES, FLAMES])
				wander_controller.start_wander_timer(randf_range(1, 3))

		HIDE:
			hurt_box.process_mode = Node.PROCESS_MODE_DISABLED
			animation_player.play("disappearing")
			var player = player_detection_zone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = HIDING
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([HIDING, HIDING, HIDING])
				
				
				wander_controller.start_wander_timer(randf_range(1, 3))
		HIDING:
			var player = player_detection_zone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = FLAMES
			if wander_controller.get_time_left() == 0:
				state = pick_random_state([ FLAMES, HIDING, HIDING, HIDING])
				
				player_detection_zone.process_mode = Node.PROCESS_MODE_DISABLED
				
				wander_controller.start_wander_timer(randf_range(1, 3))

	move_and_slide()


func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

func seek_player():
	if player_detection_zone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	progress_bar.value -= area.damage
	hurt_box.create_hit_effect()
	progress_bar.visible = true


func spawn_flame():
	var new_flame = preload("res://Enemies/dashing_flame.tscn").instantiate()
	%SecondFollowPath.progress_ratio = randf()
	new_flame.global_position = %SecondFollowPath.global_position
	get_parent().add_child.call_deferred(new_flame)

func spawn_true_ghost():
	var new_ghost = preload("res://Enemies/true_ghost.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_ghost.global_position = %PathFollow2D.global_position
	get_parent().add_child.call_deferred(new_ghost)


func _on_spawn_true_ghost_timer_timeout() -> void:
	spawn_true_ghost()


func _on_spawn_flame_timer_timeout() -> void:
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()
	spawn_flame()

signal boss_health_depleted


func _on_hurtbox_area_exited(area: Area2D) -> void:
	progress_bar.visible = false
