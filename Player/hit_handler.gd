class_name PHitHandler
extends PlayerComponent

func process_hit(data: DamageData) -> void:
    prints(p, data.health)
    p.velocity = data.knockback * (0.005 * p.health + 1)
    p.health += data.health
    p.health_indicator.value = p.health
    p.state = p.MoveState.Stunned
    %Sprites.modulate = Color(0.7, 0.7, 0.7, 1.0)
