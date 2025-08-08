extends PlayerComponent

const JUMP_FORCE: float = -750.0
const PUSHBACK_FORCE: float = 600.0

func _unhandled_input(event: InputEvent) -> void:
    if p.is_on_wall_only() and p.inp.event_is_action_pressed(event, &"jump"):
        p.velocity.y = JUMP_FORCE
        p.velocity.x = PUSHBACK_FORCE * p.get_wall_normal().x
