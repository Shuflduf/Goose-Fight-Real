class_name BoringAttack
extends Attack

func conditions(event: InputEvent) -> Array[bool]:
    #var key: StringName
    var tilt: AttackHandler.Tilts
    match bind:
        AttackHandler.Binds.Jab:
            tilt = AttackHandler.Tilts.None
        AttackHandler.Binds.FTilt:
            tilt = AttackHandler.Tilts.Forward
        AttackHandler.Binds.UTilt:
            tilt = AttackHandler.Tilts.Up
        AttackHandler.Binds.DTilt:
            tilt = AttackHandler.Tilts.Down

    return [
        p.inp.event_is_action_pressed(event, &"basic_attack"),
        p.is_on_floor(),
        p.can_move,
        ah.current_tilt == tilt,
    ]

func conditions_met(event: InputEvent) -> bool:
    return conditions(event).all(func(c: bool) -> bool: return c)

func _unhandled_input(event: InputEvent) -> void:
    if conditions_met(event):
        print("AAA")
        start()
        $Anim.play(&"start")

func boost() -> void:
    p.velocity.x += -150.0 * dir_mult()

func swing() -> void:
    # TODO: this should work on more than just players, like objects
    for b: Player in $HitBox.get_overlapping_bodies():
        if b == p:
            continue

        DebugDraw2D.set_text("hit", b, 0, Color.WHITE, 0.2)
        var data: DamageData = DamageData.new()
        data.health = 5
        damage.emit(data, b)
        break
