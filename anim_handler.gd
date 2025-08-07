extends PlayerComponent

@export var sprites: AnimatedSprite2D

func _physics_process(_delta: float) -> void:
    if sprites.animation == &"air" and p.is_on_floor():
        sprites.play(&"idle")
    if sprites.animation in [&"idle", &"walk", &"run"] and not p.is_on_floor():
        sprites.play(&"air")
    DebugDraw2D.set_text("anim", sprites.animation)

func _on_vertical_movement_jumped() -> void:
    sprites.play(&"jump")


func _on_vertical_movement_jump_queued() -> void:
    sprites.play(&"jump_queue")


func _on_sprites_animation_finished() -> void:
    match sprites.animation:
        &"jump":
            sprites.play(&"air")


func _on_horizontal_movement_moved(is_run: bool) -> void:
    var correct_anim: StringName = &"run" if is_run else &"walk"
    if not sprites.animation in [&"jump_queue", correct_anim] and p.is_on_floor():
        sprites.play(correct_anim)


func _on_horizontal_movement_didnt_move() -> void:
    if not sprites.animation in [&"idle", &"jump_queue"] and p.is_on_floor():
        sprites.play(&"idle")
