class_name NSpecAttack
extends Attack

@export var bullet_scene: PackedScene

func shoot() -> void:
    var proj_data: DamageData = DamageData.new()
    proj_data.health = 2

    p.velocity.x = dir_mult() * 500.0
    var new_bullet: Projectile = bullet_scene.instantiate()
    add_child(new_bullet)
    new_bullet.global_position = global_position
    new_bullet.hit.connect(_on_bullet_hit)
    new_bullet.p = p
    new_bullet.data = proj_data
    new_bullet.direction = Vector2((1.0 if ah.facing_right else -1.0), 0.0)

func _on_bullet_hit(data: DamageData, body: Player) -> void:
    damage.emit(data, body)
