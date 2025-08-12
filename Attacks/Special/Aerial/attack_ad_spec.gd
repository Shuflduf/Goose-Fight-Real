extends Attack

@export var bomb_scene: PackedScene

var last_bomb: Projectile

func spawn_bomb() -> void:
    p.velocity.y = -300.0

    if last_bomb:
        last_bomb.explode()

    last_bomb = bomb_scene.instantiate()
    add_child(last_bomb)
    last_bomb.global_position = global_position
    last_bomb.velocity.y = 50.0
    last_bomb.p = p
    last_bomb.hit.connect(_on_bomb_hit)


func _on_bomb_hit(data: DamageData, body: Player) -> void:
    damage.emit(data, body)
