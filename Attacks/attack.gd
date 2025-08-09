class_name Attack
extends Node2D

signal started(anim_name: StringName)
@warning_ignore("unused_signal")
signal damage(data: DamageData, body: Player)

@onready var handler: AttackHandler = get_parent()

@export var anim_name: StringName

var p: Player
var ah: AttackHandler
var bind: AttackHandler.Binds
#var facing_right: bool = false

func start() -> void:
    started.emit(anim_name)

func flip() -> void:
    pass

func dir_mult() -> int:
    return -1 if handler.facing_right else 1

func conditions(event: InputEvent) -> Array[bool]:
    var key: StringName
    var tilt: AttackHandler.Tilts
    match bind:
        AttackHandler.Binds.Jab:
            tilt = AttackHandler.Tilts.None
        AttackHandler.Binds.FTilt:
            tilt = AttackHandler.Tilts.Forward
        AttackHandler.Binds.UTilt:
            tilt = AttackHandler.Tilts.Up
        AttackHandler.Binds.DTilt:
            tilt = AttackHandler.Tilts.Down
    match bind:
        AttackHandler.Binds.Jab, \
        AttackHandler.Binds.FTilt, \
        AttackHandler.Binds.UTilt, \
        AttackHandler.Binds.DTilt:
            key = &"basic_attack"
        AttackHandler.Binds.NSpec:
            key = &"special_attack"

    return [
        p.inp.event_is_action_just_pressed(event, key),
        p.is_on_floor(),
        p.state != Player.MoveState.None,
        ah.current_tilt == tilt,
    ]

func conditions_met(event: InputEvent) -> bool:
    return conditions(event).all(func(c: bool) -> bool: return c)

func _unhandled_input(event: InputEvent) -> void:
    if conditions_met(event):
        p.state = Player.MoveState.None
        start()
        $Anim.play(&"start")
