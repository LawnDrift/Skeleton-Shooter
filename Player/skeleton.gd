extends CharacterBody2D
class_name Player
@onready var skeleton_sprite: Sprite2D = $SkeletonSprite
@onready var hurt_box: Area2D = $PlayerHurtbox
@onready var gun: Sprite2D = $Gun
@onready var marker: Marker2D = $Gun/Marker2D
@onready var big_gun: Sprite2D = $BigGun
@onready var ghost_gun: Sprite2D = $GhostGun
@onready var big_ghost_gun: Sprite2D = $BigGhostGun


@export var SPEED = 80

func _ready() -> void:
	gun.visible = false
	check_item_number()

func _process(delta: float) -> void:
	check_item_number()

func check_item_number():
	if PlayerInventory.item_number == 1:
		big_gun.process_mode = Node.PROCESS_MODE_DISABLED
		ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
		big_ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
		
		gun.process_mode = Node.PROCESS_MODE_INHERIT
		marker.process_mode = Node.PROCESS_MODE_INHERIT
		gun.visible = true
		
	elif PlayerInventory.item_number == 2:
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		marker.process_mode = Node.PROCESS_MODE_DISABLED
		ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
		big_ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
		
		big_gun.process_mode = Node.PROCESS_MODE_INHERIT
		big_gun.visible = true
	elif PlayerInventory.item_number == 3:
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		marker.process_mode = Node.PROCESS_MODE_DISABLED
		big_gun.process_mode = Node.PROCESS_MODE_DISABLED
		big_ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
		
		ghost_gun.process_mode = Node.PROCESS_MODE_INHERIT
		ghost_gun.visible = true
		
	elif PlayerInventory.item_number == 4:
		gun.process_mode = Node.PROCESS_MODE_DISABLED
		marker.process_mode = Node.PROCESS_MODE_DISABLED
		big_gun.process_mode = Node.PROCESS_MODE_DISABLED
		ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
		
		big_ghost_gun.process_mode = Node.PROCESS_MODE_INHERIT
		big_ghost_gun.visible = true


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	if  direction.x < 0:
		skeleton_sprite.flip_h = true
	if direction.x > 0:
		skeleton_sprite.flip_h = false

	move_and_slide()



func _on_hurtbox_area_entered(area: Area2D) -> void:
	hurt_box.start_invincibility(0.7)
	hurt_box.create_hit_effect()
	PlayerStats.health -= area.damage
	if PlayerStats.health <= 0:
		health_depleted.emit()

signal health_depleted
