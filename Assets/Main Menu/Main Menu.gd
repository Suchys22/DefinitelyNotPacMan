extends Control


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBoxContainer/Start.grab_focus()

func _on_Start_pressed() -> void:
	get_tree().change_scene("res://Assets/Levels/Map.tscn")

func _on_Options_pressed() -> void:
	pass # Replace with function body.

func _on_Quit_pressed() -> void:
	get_tree().quit()



