extends PlayerComponent

@export var sprites: AnimatedSprite2D

#var attack_anims: Array

#func _ready() -> void:
    #attack_anims = Array(sprites.sprite_frames.get_animation_names()).map(func(n: String) -> StringName: return StringName(n))

func _physics_process(_delta: float) -> void:
    if sprites.animation == &"air" and p.is_on_floor():
        sprites.play(&"idle")
    if sprites.animation in [&"idle", &"walk", &"run"] and not p.is_on_floor():
        sprites.play(&"air")

func _on_vertical_movement_jumped() -> void:
    sprites.play(&"jump")


func _on_vertical_movement_jump_queued() -> void:
    sprites.play(&"jump_queue")


func _on_sprites_animation_finished() -> void:
    match sprites.animation:
        &"jump":
            sprites.play(&"air")
        &"flip":
            sprites.play(&"walk")


func _on_horizontal_movement_moved(is_run: bool) -> void:
    if not p.can_move:
        return
    var correct_anim: StringName = &"run" if is_run else &"walk"
    if not sprites.animation in [&"jump_queue", &"flip", correct_anim] and p.is_on_floor():
        sprites.play(correct_anim)


func _on_horizontal_movement_didnt_move() -> void:
    if not p.can_move:
        return
    if not sprites.animation in [&"idle", &"jump_queue"] and p.is_on_floor():
        sprites.play(&"idle")


func _on_horizontal_movement_flip(right: bool) -> void:
    if sprites.flip_h != right:
        sprites.play(&"flip")
        sprites.flip_h = right


func _on_attacks_attack_started(anim_name: StringName) -> void:
    sprites.play(anim_name)
