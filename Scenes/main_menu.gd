extends Node2D

func _process(_delta: float) -> void:
    var offset: Vector2 = %Center.get_local_mouse_position() - %Cam.position
    print(offset)
    %Cam.position = offset / 50.0


func _on_start_pressed() -> void:
    get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_close_pressed() -> void:
    %GuideContainer.hide()


func _on_guide_pressed() -> void:
    %GuideContainer.show()
