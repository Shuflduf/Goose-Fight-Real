class_name AttackHandler
extends PlayerComponent

signal attack_started(anim_name: StringName)

@export var attacks: Array[AttackInfo]
@export var sprites: AnimatedSprite2D

enum AttackBind {
    Jab,
    FTilt,
    UTilt,
    DTilt,
}
enum Tilts {
    None,
    Forward,
    Backward,
    Up,
    Down,
}

var current_tilt: Tilts = Tilts.None
var facing_right: bool = false

#func _unhandled_input(event: InputEvent) -> void:


func _ready() -> void:
    await get_tree().physics_frame
    for a in attacks:
        var new_attack: Attack = a.scene.instantiate()
        add_child(new_attack)
        new_attack.started.connect(_on_attack_started)
        new_attack.p = p


func _on_attack_started(anim_name: StringName) -> void:
    attack_started.emit(anim_name)
    p.can_move = false


func _on_sprites_animation_finished() -> void:
    if sprites.animation.begins_with("attack"):
        p.can_move = true


func _on_horizontal_movement_flip(right: bool) -> void:
    facing_right = right
    for a: Attack in get_children():
        a.flip()
