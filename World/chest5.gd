#FinalChest

extends StaticBody2D


@onready var sprite: Sprite2D = $Sprite2D
@onready var big_ghost_gun: Sprite2D = $BigGhostGun



var is_in_area = false
var item_ready = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.z_index = 1
	big_ghost_gun.process_mode = Node.PROCESS_MODE_DISABLED
	big_ghost_gun.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_chest") and is_in_area == true:
		sprite.frame = 1
		if big_ghost_gun != null:
			big_ghost_gun.process_mode = Node.PROCESS_MODE_INHERIT
			big_ghost_gun.visible = true
		boss_ready.emit()


	if Input.is_action_just_pressed("open_chest") and item_ready == true:
		print("item taken")
		item_ready = false
		#This is super important becauses this changes the item
		PlayerInventory.item_number = 4
		
		print("item number: ", PlayerInventory.item_number)
		big_ghost_gun.queue_free()


func _on_chest_zone_body_entered(body: Node2D) -> void:
	is_in_area = true



func _on_chest_zone_body_exited(body: Node2D) -> void:
	is_in_area = false


func _on_item_zone_body_entered(body: Node2D) -> void:
	item_ready = true


signal boss_ready
