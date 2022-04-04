extends KinematicBody

var path = []
var path_node = 0

var speed = 4

export(NodePath) var NavNode
onready var nav = get_node(NavNode)
export(NodePath) var PlayerNode
onready var player = get_node(PlayerNode)
onready var anim = $AnimationPlayer

func _physics_process(delta):
	if not anim.is_playing():
		anim.play("Open")
		anim.queue("Close")
	if path_node < path.size():
		var direction = (path[path_node] - global_transform.origin)
		if direction.length() < 1:
			path_node += 1
		else:
			move_and_slide(direction.normalized() * speed, Vector3.UP)
			rotation.y = lerp_angle(rotation.y, atan2(direction.x, direction.z), delta + .2)
		var attack_vector: Vector3 = player.translation  - translation
		var distance = attack_vector.length()
		print(distance)
		if distance < 2.2:
			player.queue_free()
			get_tree().change_scene("res://Assets/Main Menu/Main Menu.tscn")
			print("Smutné umřel jsi.")
		if distance < 20:
			speed = 7
			print(speed)
		else:
			speed = 4
			
func move_to(target_pos):
	path = nav.get_simple_path(global_transform.origin, target_pos)
	path_node = 0
	
func _on_Timer_timeout():
	move_to(player.global_transform.origin)
	
