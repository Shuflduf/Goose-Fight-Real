extends PlayerComponent

@export var sprites: AnimatedSprite2D

func _physics_process(_delta: float) -> void:
    if sprites.animation == &"air" and p.is_on_floor():
        sprites.play(&"idle")
    if sprites.animation != &"air" and not p.is_on_floor():
        sprites.play(&"air")

func _on_vertical_movement_jumped() -> void:
    sprites.play(&"jump")


func _on_vertical_movement_jump_queued() -> void:
    sprites.play(&"jump_queue")


func _on_sprites_animation_finished() -> void:
    match sprites.animation:
        &"jump":
            sprites.play(&"air")
