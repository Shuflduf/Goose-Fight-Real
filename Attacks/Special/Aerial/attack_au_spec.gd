extends USpecAttack

const AIR_BOOST_STRENGTH: float = -800.0

func boost() -> void:
    p.velocity.y = AIR_BOOST_STRENGTH
    p.velocity.x = -200.0 * dir_mult()
