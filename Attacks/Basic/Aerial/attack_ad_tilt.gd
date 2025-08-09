extends BoringAttack

const BOOST_STRENGTH = 300.0

func boost() -> void:
    p.velocity.y = -BOOST_STRENGTH
