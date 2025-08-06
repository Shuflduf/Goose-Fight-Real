extends CharacterBody2D

const MAX_FALL: float = 450.0
const JUMP_FORCE: float = -350.0
const HOP_FORCE: float = -200.0
const HOP_WINDOW: float = 0.1

var jumping: bool = false
var jump_timer: float = 0.0
var has_double_jump: bool = false

func _physics_process(delta: float) -> void:
    var input_dir: float = Input.get_axis("ui_left", "ui_right")
    velocity.x = lerp(velocity.x, input_dir * 200.0, delta * 30.0)

    handle_vertical(delta)
    move_and_slide()

func handle_vertical(delta: float) -> void:
    velocity.y += get_gravity().y * delta
    velocity.y = min(velocity.y, MAX_FALL)

    if is_on_floor():
        has_double_jump = true

    if Input.is_action_just_pressed(&"jump"):
        if is_on_floor():
            jump_timer = 0.0
            jumping = true
        elif has_double_jump:
            apply_jump_vel(JUMP_FORCE)
            has_double_jump = false

    if jumping:
        if Input.is_action_just_released(&"jump"):
            velocity.y = HOP_FORCE
            jumping = false

        jump_timer += delta
        if jump_timer > HOP_WINDOW:
            apply_jump_vel(JUMP_FORCE)


func apply_jump_vel(strength: float) -> void:
    velocity.y = strength
    jumping = false
