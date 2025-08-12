class_name USpecAttack
extends BoringAttack

const BOOST_STRENGTH: float = -900.0

func slow() -> void:
    p.velocity.y = min(p.velocity.y, 0.0)

func boost() -> void:
    p.velocity.y = BOOST_STRENGTH
    p.velocity.x = -400.0 * dir_mult()
