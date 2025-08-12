extends Projectile

var a: Attack
var right: bool = false
var speed: float = 10.0

func _ready() -> void:
    await get_tree().physics_frame
    right = a.ah.facing_right
    $Sprite.flip_h = right

    #data.knockback.x = data.knockback.x * (1.0 if right else -1.0)

func _physics_process(delta: float) -> void:
    velocity.y += get_gravity().y * delta
    velocity.x = speed * (1.0 if right else -1.0)

    move_and_slide()

func explode() -> void:
    return
