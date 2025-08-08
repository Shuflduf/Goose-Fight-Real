class_name InputHandler
extends PlayerComponent

func event_is_action_pressed(event: InputEvent, action: StringName) -> bool:
    if p.input_index == -1:
        if event is InputEventKey:
            return event.is_action_pressed(action)
    else:
        if event.device == p.input_index:
            return event.is_action_pressed(action)
    return false
