class_name BoringAttack
extends Attack

@onready var hitbox_leftpos: float = %Shape.position.x

func flip() -> void:
    var new_pos: float = hitbox_leftpos * dir_mult()
    %Shape.position.x = new_pos

func boost() -> void:
    p.velocity.x += -150.0 * dir_mult()

func swing() -> void:
    # TODO: this should work on more than just players, like objects
    for b: Player in $HitBox.get_overlapping_bodies():
        if b == p:
            continue


        var data: DamageData = DamageData.new()
        data.health = 5
        damage.emit(data, b)
        break
