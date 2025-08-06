extends CharacterBody2D

const MAX_FALL: float = 1450.0
const JUMP_FORCE: float = -750.0
const HOP_FORCE: float = -400.0
const HOP_WINDOW: float = 0.15
const MAX_COYOTE_TIME: float = 0.1
const GRAVITY_MULT: float = 2.0

var jumping: bool = false
var jump_timer: float = 0.0
var has_double_jump: bool = false
var coyote_timer: float = 0.0

func _physics_process(delta: float) -> void:
    var input_dir: float = Input.get_axis("ui_left", "ui_right")
    velocity.x = lerp(velocity.x, input_dir * 200.0, delta * 30.0)

    handle_vertical(delta)
    move_and_slide()

func handle_vertical(delta: float) -> void:
    velocity.y += get_gravity().y * delta * GRAVITY_MULT
    velocity.y = min(velocity.y, MAX_FALL)

    if is_on_floor():
        coyote_timer = 0.0
        has_double_jump = true
    else:
        coyote_timer += delta

    if Input.is_action_just_pressed(&"jump"):
        if is_on_floor() or coyote_timer < MAX_COYOTE_TIME:
            jump_timer = 0.0
            jumping = true
        elif has_double_jump:
            apply_jump_vel(JUMP_FORCE)
            has_double_jump = false

    elif jumping:
        if Input.is_action_just_released(&"jump"):
            velocity.y = HOP_FORCE
            jumping = false
        else:
            jump_timer += delta
            if jump_timer > HOP_WINDOW:
                apply_jump_vel(JUMP_FORCE)


func apply_jump_vel(strength: float) -> void:
    velocity.y = strength
    jumping = false
