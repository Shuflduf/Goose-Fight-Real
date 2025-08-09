extends BoringAttack

var touched_ground: bool = true

func jump() -> void:

    if touched_ground:
        touched_ground = false
        p.velocity.y = -500.0
    else:
        p.velocity.y = -50.0

func _physics_process(_delta: float) -> void:
    if p.is_on_floor():
        touched_ground = true
