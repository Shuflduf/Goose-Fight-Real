extends BoringAttack

func _unhandled_input(event: InputEvent) -> void:
    if conditions_met():
        start()
        p.velocity.y = -500.0
        $Anim.play(&"start")
