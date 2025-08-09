extends BoringAttack


func boost() -> void:
    p.velocity.x = -500.0 * dir_mult()
    p.velocity.y = -300.0
