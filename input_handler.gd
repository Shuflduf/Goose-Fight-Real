class_name InputHandler
extends PlayerComponent

func event_is_action_pressed(event: InputEvent, action: StringName) -> bool:
    if not event.is_pressed():
        return false
    
    prints(p.input_index)
    if event is InputEventKey:
        if p.input_index == -1:
            print("keyboard")
            return event.is_action_pressed(action)
    else:
        if event.device == p.input_index:
            print("controler")
            return event.is_action_pressed(action)
    return false
