extends CharacterBody2D

const HALF_GRAV_THRESHOLD: float = 40.0
const GRAVITY: float = 1200.0
const MAX_FALL: float = 450.0
const JUMP_FORCE: float = -350.0
const JUMP_TIME: float = 0.15

var jump_timer: float = 0.0
var jumping: bool = false


func _physics_process(delta: float) -> void:
    var input_dir: float = Input.get_axis("ui_left", "ui_right")
    velocity.x = lerp(velocity.x, input_dir * 200.0, delta * 30.0)

    handle_vertical(delta)
    move_and_slide()

func handle_vertical(delta: float) -> void:
    DebugDraw2D.set_text("vert", [jump_timer, velocity.y])
    if not is_on_floor():
        var mult := 1.0
        if abs(velocity.y) < HALF_GRAV_THRESHOLD and Input.is_action_pressed(&"jump"):
            mult = 0.5

        velocity.y = min(velocity.y + GRAVITY * mult * delta, MAX_FALL)

        if Input.is_action_pressed(&"jump"):
            if jump_timer > 0.0:
                jump_timer -= delta
                velocity.y += (JUMP_FORCE - velocity.y) * delta * 10
        else:
            jump_timer = 0.0
    else:
        jump_timer = 0.0
        jumping = false

    if is_on_floor() and Input.is_action_just_pressed(&"jump"):
        jump()

func jump() -> void:
    velocity.y = JUMP_FORCE
    jump_timer = JUMP_TIME
    jumping = true
