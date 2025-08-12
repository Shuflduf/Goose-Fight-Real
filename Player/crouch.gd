extends PlayerComponent

signal crouched

func _unhandled_input(event: InputEvent) -> void:
    if p.state not in [Player.MoveState.None, Player.MoveState.Stunned]:
        if p.inp.event_is_action_just_pressed(event, &"down") and p.is_on_floor():
            p.state = Player.MoveState.VertOnly
            crouched.emit()
        elif p.inp.event_is_action_just_released(event, &"down"):
            p.state = Player.MoveState.Both
