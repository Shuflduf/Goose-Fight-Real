class_name FSpecVehicle
extends CharacterBody2D


#var right: bool = false
var a: Attack
var right: bool = false
var speed: float = 10.0

func _ready() -> void:
    await get_tree().physics_frame
    $Sprite.flip_h = a.ah.facing_right
    right = a.ah.facing_right

func _physics_process(delta: float) -> void:
    velocity.y += get_gravity().y * delta
    velocity.x = speed * (1.0 if right else -1.0)

    move_and_slide()
