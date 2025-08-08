class_name InputHandler
extends PlayerComponent

func event_is_action_pressed(event: InputEvent, action: StringName) -> bool:
    if not event.is_pressed():
        return false

    if verify_device(event):
        return event.is_action_pressed(action)
    else:
        return false

func event_is_action_released(event: InputEvent, action: StringName) -> bool:
    if event.is_pressed():
        return false

    if verify_device(event):
        return event.is_action_released(action)
    else:
        return false

func verify_device(event: InputEvent) -> bool:
    if event is InputEventKey:
        if p.input_index == -1:
            return true
    else:
        if event.device == p.input_index:
            return true
    return false
