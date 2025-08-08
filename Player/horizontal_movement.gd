class_name PHorizMovement
extends PlayerComponent

signal moved(is_run: bool)
signal didnt_move
signal flip(right: bool)

@export var sprites: AnimatedSprite2D

const WALK_SPEED: float = 250.0
const RUN_SPEED: float = 450.0
const RUN_WINDOW: float = 0.2
const GROUND_ACCEL: float = 20.0
const AIR_ACCEL: float = 8.0

var running: bool = false
var run_timer: float = 0.0
var last_run_dir: int = 0

var input_dir: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventJoypadMotion and event.device == p.input_index:
        if event.axis == JOY_AXIS_LEFT_X:
            input_dir = roundf(event.axis_value)

func _physics_process(delta: float) -> void:
    if p.input_index == -1:
        input_dir = Input.get_axis(&"left", &"right")

    if p.state != p.MoveState.Both:
        input_dir = 0.0

    var current_dir: int = int(input_dir)

    if current_dir == 0:
        if last_run_dir != 0:
            run_timer += delta
    else:
        if current_dir != last_run_dir:
            running = false
            last_run_dir = current_dir
            run_timer = 0.0
        elif run_timer > 0.0:
            running = true
            run_timer = 0.0

    if run_timer > RUN_WINDOW or not p.is_on_floor():
        run_timer = 0.0
        last_run_dir = 0
        running = false

    if running and input_dir:
        p.velocity.x = input_dir * RUN_SPEED
    else:
        var accel: float = GROUND_ACCEL if p.is_on_floor() else AIR_ACCEL
        p.velocity.x = lerp(p.velocity.x, input_dir * WALK_SPEED, delta * accel)

    sprite_flipping(current_dir)
    if p.is_on_floor():
        if current_dir:
            moved.emit(running)
        else:
            didnt_move.emit()

func sprite_flipping(dir: int) -> void:
    if dir != 0:
        if p.is_on_floor():
            #sprites.flip_h =
            flip.emit(dir == 1)
