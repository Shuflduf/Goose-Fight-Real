class_name Attack
extends Node2D

signal started(anim_name: StringName)
@warning_ignore("unused_signal")
signal finished

@export var anim_name: StringName

var inp: InputHandler

func run() -> void:
    started.emit(anim_name)
