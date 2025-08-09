extends BoringAttack

func jump() -> void:
    p.velocity.y = -300.0

func fall() -> void:
    p.velocity.y = 400.0
