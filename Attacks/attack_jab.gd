extends Attack

func _unhandled_input(event: InputEvent) -> void:
    if inp.event_is_action_pressed(event, &"basic_attack"):
        run()
        await get_tree().create_timer(0.5).timeout
        finished.emit()
