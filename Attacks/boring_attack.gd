class_name BoringAttack
extends Attack

@onready var hitbox_leftpos: float = %Shape.position.x

@export var health: int = 5
@export var knockback: Vector2 = Vector2(100.0, -200.0)

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
        data.health = health
        data.knockback = Vector2(dir_mult() * -knockback.x, knockback.y)
        damage.emit(data, b)
        break
