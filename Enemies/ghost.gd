extends CharacterBody2D

const enemy_death_effect = preload("res://Effects/death_effect.tscn")

@onready var sprite: Sprite2D = $Sprite2D
@onready var stats: Node = $Stats
@onready var hurt_box: Area2D = $Hurtbox
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft

var wander_direction = 1

@export var ACCELERATION = 300
@export var MAX_SPEED = 30
@export var FRICTION= 500

@export var WANDER_SPEED = 60


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
	if ray_cast_right.is_colliding():
		wander_direction = -1
		sprite.flip_h = true
	if ray_cast_left.is_colliding():
		wander_direction = 1
		sprite.flip_h = false
	position.x += wander_direction * WANDER_SPEED * delta

	move_and_slide()




func _on_hurtbox_area_entered(area: Area2D) -> void:
	stats.health -= area.damage
	hurt_box.create_hit_effect()



func _on_stats_no_health() -> void:
	queue_free()
	var enemy_death_effect = enemy_death_effect.instantiate()
	get_parent().add_child(enemy_death_effect)
	enemy_death_effect.global_position = global_position
