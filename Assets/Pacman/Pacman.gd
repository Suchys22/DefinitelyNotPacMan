extends KinematicBody

signal player_killed()

var path = []
var current_node = 0

export var speed = 1.5

export var playerNode: NodePath
export var navMapNode: NodePath

onready var player = get_node(playerNode)
onready var navMap = get_node(navMapNode)
onready var anim = $AnimationPlayer

func _ready() -> void:
	if playerNode == null:
		print("KDE JE Player.")
	if navMapNode == null:
		print("KDE JE Navigace.")
	
func _physics_process(delta: float) -> void:
	if is_instance_valid(player):
		var attack_vector: Vector3 = player.translation  - translation
		var direction: Vector3 = attack_vector.normalized()
		var distance = attack_vector.length()
		
		if not anim.is_playing():
			anim.play("Open")
			anim.queue("Close")
	
		move_and_slide(direction * speed)
		
		if distance < 1.7:
			player.queue_free()
			get_tree().change_scene("res://Assets/Main Menu/Main Menu.tscn")
			print("Smutné umřel jsi.")
		
		rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), delta + .2)

func update_path(target_position):
	path = navMap.get_simple_path(translation, target_position)

func _on_PathUpdate_timeout() -> void:
	if is_instance_valid(player):
		update_path(player.translation)
		current_node = 0
