extends Attack

func increase_speed() -> void:
    p.hmove.movement_speed_mult += 0.5


func _physics_process(delta: float) -> void:
    var new_speed_mult: float = p.hmove.movement_speed_mult
    new_speed_mult -= delta * abs(p.hmove.input_dir) * 0.3 * new_speed_mult
    new_speed_mult = max(new_speed_mult, 1.0)
    p.hmove.movement_speed_mult = new_speed_mult
    DebugDraw2D.set_text("speed", new_speed_mult)
