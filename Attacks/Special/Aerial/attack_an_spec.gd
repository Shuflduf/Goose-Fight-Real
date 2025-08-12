extends NSpecAttack

@onready var og_shape_pos: float = %CollShape.polygon[0].x

func flip() -> void:
    var new_pos: float = og_shape_pos * dir_mult()
    %CollShape.polygon[0].x = new_pos
    %CollShape.polygon[1].x = new_pos

func shoot() -> void:
    var proj_data: DamageData = DamageData.new()
    proj_data.health = 2

    var target_dir: Vector2 = Vector2((1.0 if ah.facing_right else -1.0), 0.0)
    for b: Player in $PlayerDetection.get_overlapping_bodies():
        if b == p:
            continue

        target_dir = p.global_position.direction_to(b.global_position + Vector2(0.0, -24.0))
        if target_dir.y > 0.0:
            p.velocity.y = -200.0
        break

    p.velocity.x = dir_mult() * 500.0
    var bullet: Projectile = new_bullet()
    bullet.direction = target_dir
    bullet.data = proj_data
