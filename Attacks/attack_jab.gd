extends Attack

func _unhandled_input(event: InputEvent) -> void:
    var conditions: Array[bool] = [
        p.inp.event_is_action_pressed(event, &"basic_attack"),
        p.is_on_floor(),
        not $Anim.is_playing(),
    ]
    if conditions.all(func(c: bool) -> bool: return c):
        start()
        p.velocity.x += -150.0 * dir_mult()
        $Anim.play(&"start")
        #await get_tree().create_timer(0.5).timeout
        #finished.emit()

func swing() -> void:
    # TODO: this should work on more than just players, like objects
    for b: Player in $HitBox.get_overlapping_bodies():
        if b == p:
            continue

        print(b)
        var data: DamageData = DamageData.new()
        data.health = 5
        damage.emit(data, b)
        break
