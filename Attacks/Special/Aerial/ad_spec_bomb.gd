extends Projectile

#var can_explode: bool = false

var health: int
var knockback: float

func _on_area_body_entered(body: Node2D) -> void:
    if body == p:
        return

    var bodies: Array = $Explode.get_overlapping_bodies()
    for target: Player in bodies:
        var new_data: DamageData = DamageData.new()
        new_data.health = health

        var dir: Vector2 = global_position.direction_to(target.global_position)
        new_data.knockback = Vector2(
            knockback * dir.x,
            knockback * dir.y
        )

        hit.emit(new_data, target)

    explode()

func _ready() -> void:
    $Area.collision_mask = 0
    $Sprite.modulate = Color.DARK_GRAY

func _physics_process(delta: float) -> void:
    velocity.y += get_gravity().y * delta * 2.0

    move_and_slide()


func _on_charge_time_timeout() -> void:
    $Area.collision_mask = 4
    $Sprite.modulate = Color.WHITE
    #can_explode = true

#func explode():
