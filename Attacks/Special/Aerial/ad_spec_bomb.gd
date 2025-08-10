class_name ADSpecBomb
extends CharacterBody2D

signal hit(data: DamageData, body: Player)

var p: Player

func _physics_process(delta: float) -> void:
    velocity.y += get_gravity().y * delta

    move_and_slide()


func _on_area_body_entered(body: Node2D) -> void:
    if body == p:
        return

    var data: DamageData = DamageData.new()
    data.health = 5
    hit.emit(data, body)
    queue_free()
