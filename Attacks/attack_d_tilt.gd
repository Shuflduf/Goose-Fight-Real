extends BoringAttack

func fall() -> void:
    p.velocity.y = 400.0

func _unhandled_input(event: InputEvent) -> void:
    if conditions_met(event):
        start()
        p.velocity.y = -300.0
        $Anim.play(&"start")
