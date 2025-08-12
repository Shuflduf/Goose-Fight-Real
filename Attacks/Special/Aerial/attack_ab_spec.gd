extends BoringAttack

func start_particles() -> void:
    %Bottle.show()
    %Particles.emitting = true

func stop_particles() -> void:
    %Bottle.hide()
    %Particles.emitting = false
    p.velocity.x = -700.0 * dir_mult()


func _physics_process(delta: float) -> void:
    if %Particles.emitting:
        p.velocity.x = lerp(p.velocity.x, -500.0 * dir_mult(), delta * 10.0)
        p.velocity.y = -100.0

func flip() -> void:
    $HitBox.scale.x = dir_mult()
    $Visuals.scale.x = dir_mult()
