extends PlayerComponent

const JUMP_FORCE: float = -750.0
const PUSHBACK_FORCE: float = 600.0

func _physics_process(_delta: float) -> void:
    if p.is_on_wall_only() and Input.is_action_just_pressed(&"jump"):
        p.velocity.y = JUMP_FORCE
        p.velocity.x = PUSHBACK_FORCE * p.get_wall_normal().x
