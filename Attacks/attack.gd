class_name Attack
extends Node2D

signal started(anim_name: StringName)
@warning_ignore("unused_signal")
signal damage(data: DamageData, body: Player)

@onready var hitbox_leftpos: float = %Shape.position.x
@onready var handler: AttackHandler = get_parent()

@export var anim_name: StringName

var p: Player
var ah: AttackHandler
var bind: AttackHandler.AttackBind
#var facing_right: bool = false

func start() -> void:
    started.emit(anim_name)

func flip() -> void:
    var new_pos: float = hitbox_leftpos * dir_mult()
    %Shape.position.x = new_pos

func dir_mult() -> int:
    return -1 if handler.facing_right else 1
