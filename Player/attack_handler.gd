class_name AttackHandler
extends PlayerComponent

@export var attacks: Array[AttackInfo]
@export var sprites: AnimatedSprite2D

enum AttackBind {
    Jab,
    FTilt,
    UTilt,
    DTilt,
}

func _ready() -> void:

    await get_tree().physics_frame
    print(p.inp)
    for a in attacks:
        var new_attack: Attack = a.scene.instantiate()
        add_child(new_attack)
        new_attack.started.connect(_on_attack_started)
        new_attack.finished.connect(_on_attack_finished)
        #new_attack.set_deferred(&"inp", p.inp)
        new_attack.inp = p.inp


func _on_attack_started(anim_name: StringName) -> void:
    # TODO: make this a signal
    sprites.play(anim_name)
    p.can_move = false

func _on_attack_finished() -> void:
    sprites.play(&"idle")
    p.can_move = true
