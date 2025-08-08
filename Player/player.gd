class_name Player
extends CharacterBody2D

@onready var inp: InputHandler = $InputHandler

@export var input_index: int = -1

enum MoveState {
    Both,
    VertOnly,
    None,
}

var state: MoveState = MoveState.Both

func _physics_process(_delta: float) -> void:
    move_and_slide()
