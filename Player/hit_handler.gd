class_name PHitHandler
extends PlayerComponent

func process_hit(data: DamageData) -> void:
    p.velocity = data.knockback * (0.005 * p.health + 1)
    p.health += data.health
    p.health_indicator.value = p.health
    stun()


func stun() -> void:
    p.state = p.MoveState.Stunned
    %Sprites.modulate = Color.DIM_GRAY
    $StunTimer.start()


func _on_stun_timer_timeout() -> void:
    p.state = p.MoveState.Both
    %Sprites.modulate = Color.WHITE


func _physics_process(_delta: float) -> void:
    if p.is_on_floor() and p.state == p.MoveState.Stunned:
        $StunTimer.stop()
        # this MIGHT cause issues MAYBE
        await get_tree().create_timer(0.1).timeout
        _on_stun_timer_timeout()
