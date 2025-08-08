extends PlayerComponent

@export var inputs: InputHandler

func _unhandled_input(event: InputEvent) -> void:
    if inputs.event_is_action_pressed(event, &"jump"):
        print(p.input_index)
