class_name InputHandler
extends PlayerComponent

var pressed_keys: Dictionary[StringName, bool]
var input_map: Array[StringName]

func _ready() -> void:
    input_map = InputMap.get_actions().filter(
        func(s: StringName) -> bool:
            return not s.begins_with("ui")
    )
    for i in input_map:
        pressed_keys[i] = false

func _unhandled_input(event: InputEvent) -> void:
    if not verify_device(event):
        return

    if event is InputEventMouseMotion:
        return

    for i in input_map:
        if event.is_action_pressed(i):
            pressed_keys[i] = true
        elif event.is_action_released(i):
            pressed_keys[i] = false

func event_is_action_just_pressed(event: InputEvent, action: StringName) -> bool:
    if not event.is_pressed():
        return false

    if verify_device(event):
        return event.is_action_pressed(action)
    else:
        return false

func event_is_action_just_released(event: InputEvent, action: StringName) -> bool:
    if event.is_pressed():
        return false

    if verify_device(event):
        return event.is_action_released(action)
    else:
        return false

func get_axis(left: StringName, right: StringName) -> float:
    var val: float = (-1.0 if pressed_keys[left] else 0.0) + (1.0 if pressed_keys[right] else 0.0)
    return val

func verify_device(event: InputEvent) -> bool:
    if event is InputEventKey:
        if p.input_index == -1:
            return true
    else:
        if event.device == p.input_index:
            return true
    return false
