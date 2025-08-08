extends BoringAttack

func conditions(event: InputEvent) -> Array[bool]:
    return [
        p.inp.event_is_action_pressed(event, &"basic_attack"),
        p.is_on_floor(),
        p.can_move,
        ah.current_tilt == AttackHandler.Tilts.Forward,
    ]

func boost() -> void:
    p.velocity.x += -1200.0 * dir_mult()
