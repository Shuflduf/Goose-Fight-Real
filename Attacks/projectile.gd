class_name Projectile
extends CharacterBody2D

signal hit(data: DamageData, body: Player)

var p: Player
var data: DamageData = DamageData.new()

func _on_area_body_entered(body: Node2D) -> void:
    if body == p:
        return

    hit.emit(data, body)
    explode()


func explode() -> void:
    queue_free()
