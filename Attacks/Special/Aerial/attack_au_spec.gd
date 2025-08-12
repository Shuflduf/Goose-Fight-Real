extends USpecAttack

const AIR_BOOST_STRENGTH: float = -800.0
const FAILED_BOOST_STRENGTH: float = -300.0

var can_boost: bool = true

func boost() -> void:
    if can_boost:
        p.velocity.y = AIR_BOOST_STRENGTH
        p.velocity.x = -200.0 * dir_mult()
        can_boost = false
    else:
        p.velocity.y = FAILED_BOOST_STRENGTH
        p.velocity.x = -100.0 * dir_mult()

func _physics_process(_delta: float) -> void:
    if p.is_on_floor():
        can_boost = true


func _ready() -> void:
    await get_tree().physics_frame
    p.wall_jump.jumped.connect(_on_wall_jump)


func _on_wall_jump() -> void:
    can_boost = true
