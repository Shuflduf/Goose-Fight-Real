class_name NSpecAttack
extends Attack

@export var bullet_scene: PackedScene

func shoot() -> void:
    var proj_data: DamageData = DamageData.new()
    proj_data.health = 2

    p.velocity.x = dir_mult() * 500.0
    var bullet: Projectile = new_bullet()
    bullet.direction = Vector2((1.0 if ah.facing_right else -1.0), 0.0)
    bullet.data = proj_data


func _on_bullet_hit(data: DamageData, body: Player) -> void:
    damage.emit(data, body)


func new_bullet() -> Projectile:
    var bullet: Projectile = bullet_scene.instantiate()
    add_child(bullet)
    bullet.global_position = global_position
    bullet.hit.connect(_on_bullet_hit)
    bullet.p = p
    return bullet
