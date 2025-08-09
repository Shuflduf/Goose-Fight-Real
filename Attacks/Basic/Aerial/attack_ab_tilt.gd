extends BoringAttack

func boost() -> void:
    p.velocity.x += 300.0 * dir_mult()
