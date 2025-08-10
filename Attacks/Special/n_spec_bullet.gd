class_name NSpecBullet
extends Projectile

var direction: Vector2 = Vector2.LEFT

func _physics_process(delta: float) -> void:
    position += delta * direction * 500.0
