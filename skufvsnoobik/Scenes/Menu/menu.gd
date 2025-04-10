extends Control


func _on_play_pressed() -> void:
	if GlobalControl.lvl == 0:
		get_tree().change_scene_to_file("res://Scenes/Intro/intro.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
