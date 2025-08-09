extends NSpecAttack

@onready var og_shape_pos: float = %CollShape.polygon[0].x

func flip() -> void:
    var new_pos: float = og_shape_pos * dir_mult()
    %CollShape.polygon[0].x = new_pos
    %CollShape.polygon[1].x = new_pos

func shoot() -> void:
    var target_dir: Vector2 = Vector2((1.0 if ah.facing_right else -1.0), 0.0)
    for b: Player in $PlayerDetection.get_overlapping_bodies():
        if b == p:
            continue

        target_dir = p.global_position.direction_to(b.global_position)
        break

    p.velocity.x = dir_mult() * 500.0
    var new_bullet: NSpecBullet = bullet_scene.instantiate()
    add_child(new_bullet)
    new_bullet.global_position = global_position
    new_bullet.direction = target_dir
    new_bullet.hit.connect(_on_bullet_hit)
    new_bullet.p = p
