extends PlayerComponent

const MAX_FALL: float = 1450.0
const JUMP_FORCE: float = -750.0
const HOP_FORCE: float = -400.0
const HOP_WINDOW: float = 0.1
const MAX_COYOTE_TIME: float = 0.1
const GRAVITY_MULT: float = 2.0
const QUICK_DROP_TIME: float = 0.2

var jumping: bool = false
var jump_timer: float = 0.0
var has_double_jump: bool = false
var coyote_timer: float = 0.0
var quick_drop_timer: float = 0.0
var drop_queued: bool = false

func _physics_process(delta: float) -> void:
    p.velocity.y += p.get_gravity().y * delta * GRAVITY_MULT
    p.velocity.y = min(p.velocity.y, MAX_FALL)

    if p.is_on_floor():
        coyote_timer = 0.0
        has_double_jump = true
        quick_drop_timer = 0.0
    else:
        coyote_timer += delta

    if Input.is_action_just_pressed(&"jump"):
        if p.is_on_floor() or coyote_timer < MAX_COYOTE_TIME:
            jump_timer = 0.0
            jumping = true
        elif has_double_jump:
            apply_jump_vel(JUMP_FORCE)
            has_double_jump = false

    elif jumping:
        if Input.is_action_just_released(&"jump"):
            apply_jump_vel(HOP_FORCE)
            jumping = false
        else:
            jump_timer += delta
            if jump_timer > HOP_WINDOW:
                apply_jump_vel(JUMP_FORCE)

    if Input.is_action_just_released(&"down") and quick_drop_timer == 0.0:
        quick_drop_timer += delta

    if quick_drop_timer != 0.0:
        quick_drop_timer += delta
        if Input.is_action_just_pressed(&"down"):
            p.velocity.y = MAX_FALL

    if quick_drop_timer > QUICK_DROP_TIME:
        quick_drop_timer = 0.0

func apply_jump_vel(strength: float) -> void:
    p.velocity.y = strength
    jumping = false
    var input_dir: float = Input.get_axis(&"left", &"right")
    p.velocity.x = input_dir * PHorizMovement.WALK_SPEED
