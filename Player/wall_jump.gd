class_name PWallJumps
extends PlayerComponent

signal jumped

const JUMP_FORCE: float = -750.0
const PUSHBACK_FORCE: float = 600.0

var has_walljump: bool = true

func _unhandled_input(event: InputEvent) -> void:
    if p.is_on_wall_only() and p.inp.event_is_action_just_pressed(event, &"jump") and has_walljump:
        p.velocity.y = JUMP_FORCE
        p.velocity.x = PUSHBACK_FORCE * p.get_wall_normal().x
        has_walljump = false
        jumped.emit()


func _physics_process(_delta: float) -> void:
    if p.is_on_floor():
        has_walljump = true
