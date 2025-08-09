class_name NSpecBullet
extends Area2D

signal hit(data: DamageData, body: Player)

var direction: Vector2 = Vector2.LEFT
var p: Player

func _physics_process(delta: float) -> void:
    position += delta * direction * 500.0


func _on_body_entered(body: Node2D) -> void:
    if body == p:
        return

    var data: DamageData = DamageData.new()
    data.health = 5
    hit.emit(data, body)
    queue_free()
