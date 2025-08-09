class_name Attack
extends Node2D

signal started(anim_name: StringName)
@warning_ignore("unused_signal")
signal finished_early
@warning_ignore("unused_signal")
signal damage(data: DamageData, body: Player)

@export var anim_name: StringName

var p: Player
var ah: AttackHandler
var bind: AttackHandler.Binds
var airial: bool

func start() -> void:
    started.emit(anim_name)
    $Anim.play(&"start")

func flip() -> void:
    pass

func dir_mult() -> int:
    return -1 if ah.facing_right else 1

func conditions() -> Array[bool]:
    var key: StringName
    var tilt: AttackHandler.Tilts
    match bind:
        AttackHandler.Binds.Jab, \
        AttackHandler.Binds.NSpec:
            tilt = AttackHandler.Tilts.None
        AttackHandler.Binds.FTilt, \
        AttackHandler.Binds.FSpec, \
        AttackHandler.Binds.Dash:
            tilt = AttackHandler.Tilts.Forward
        AttackHandler.Binds.UTilt, \
        AttackHandler.Binds.USpec:
            tilt = AttackHandler.Tilts.Up
        AttackHandler.Binds.DTilt, \
        AttackHandler.Binds.DSpec:
            tilt = AttackHandler.Tilts.Down
    match bind:
        AttackHandler.Binds.Jab, \
        AttackHandler.Binds.Dash, \
        AttackHandler.Binds.FTilt, \
        AttackHandler.Binds.UTilt, \
        AttackHandler.Binds.DTilt:
            key = &"basic_attack"
        AttackHandler.Binds.NSpec, \
        AttackHandler.Binds.FSpec, \
        AttackHandler.Binds.USpec, \
        AttackHandler.Binds.DSpec:
            key = &"special_attack"

    var conds: Array[bool] = [
        p.inp.is_action_pressed(key),
        p.state != Player.MoveState.None,
        ah.current_tilt == tilt,
        p.is_on_floor() != airial,
        not $Anim.is_playing()
    ]

    if bind == AttackHandler.Binds.Dash:
        conds.push_back(p.hmove.running)
    elif bind == AttackHandler.Binds.FTilt:
        conds.push_back(not p.hmove.running)

    return conds

func conditions_met() -> bool:
    return conditions().all(func(c: bool) -> bool: return c)

func _unhandled_input(_event: InputEvent) -> void:
    if conditions_met():
        p.state = Player.MoveState.None
        start()
        $Anim.play(&"start")
