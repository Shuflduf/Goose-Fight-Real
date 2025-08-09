extends BoringAttack

func slow() -> void:
    p.velocity.y = 0.0

func boost() -> void:
    p.velocity.y = -1200.0
    p.velocity.x = -400.0 * dir_mult()
