extends PlayerComponent

signal jump_queued
signal jumped

@export var h_movement: PHorizMovement

const MAX_FALL: float = 1000.0
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
var dropping: bool = false

func _unhandled_input(event: InputEvent) -> void:
    if not p.can_move:
        return

    if p.inp.event_is_action_pressed(event, &"jump"):
        if p.is_on_floor() or coyote_timer < MAX_COYOTE_TIME:
            jump_timer = 0.0
            coyote_timer = MAX_COYOTE_TIME
            jumping = true
            jump_queued.emit()
        elif has_double_jump:
            apply_jump_vel(JUMP_FORCE)
            has_double_jump = false

    if p.inp.event_is_action_pressed(event, &"down") and not p.is_on_floor():
        p.collision_mask = 1
    elif p.inp.event_is_action_released(event, &"down") and not p.is_on_floor():
        p.collision_mask = 3

    if jumping and p.inp.event_is_action_released(event, &"jump"):
        apply_jump_vel(HOP_FORCE)
        jumping = false

    if p.inp.event_is_action_released(event, &"down") and quick_drop_timer == 0.0:
        quick_drop_timer += 0.001

    if quick_drop_timer != 0.0:
        if p.inp.event_is_action_pressed(event, &"down"):
            p.velocity.y = MAX_FALL
            p.collision_mask = 1


func _physics_process(delta: float) -> void:
    p.velocity.y += p.get_gravity().y * delta * GRAVITY_MULT
    p.velocity.y = min(p.velocity.y, MAX_FALL)

    #DebugDraw2D.set_text("wall", [p.is_on_wall_only(), p.get_wall_normal()])

    if p.is_on_floor():
        coyote_timer = 0.0
        has_double_jump = true
        p.collision_mask = 3
    else:
        coyote_timer += delta

    #if Input.is_action_just_pressed(&"jump"):
    if jumping:
        jump_timer += delta
        if jump_timer > HOP_WINDOW:
            apply_jump_vel(JUMP_FORCE)


    if quick_drop_timer != 0.0:
        quick_drop_timer += delta


    if quick_drop_timer > QUICK_DROP_TIME:
        quick_drop_timer = 0.0

func apply_jump_vel(strength: float) -> void:
    p.collision_mask = 3
    jumping = false
    p.velocity.y = strength
    p.velocity.x = h_movement.input_dir * PHorizMovement.WALK_SPEED
    jumped.emit()
