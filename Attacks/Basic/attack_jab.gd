extends BoringAttack

func _unhandled_input(event: InputEvent) -> void:
    if conditions_met():
        start()
        swing()
        boost()
