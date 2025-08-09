extends BoringAttack

func boost() -> void:
    p.velocity.x += -1000.0 * dir_mult()
    p.velocity.y += -350.0
