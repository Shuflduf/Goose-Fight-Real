class_name PHitHandler
extends PlayerComponent

func process_hit(data: DamageData) -> void:
    prints(p, data.health)
    p.velocity = data.knockback
