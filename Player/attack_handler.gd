class_name AttackHandler
extends PlayerComponent

signal attack_started(anim_name: StringName)

@export var attacks: Array[AttackInfo]
@export var sprites: AnimatedSprite2D

enum Binds {
    Jab,
    FTilt,
    UTilt,
    DTilt,
    NSpec,
}
enum Tilts {
    None,
    Forward,
    Backward,
    Up,
    Down,
}

var dir_inputs: Dictionary[StringName, bool] = {
    &"left": false,
    &"right": false,
    &"up": false,
    &"down": false,
}
var current_tilt: Tilts = Tilts.None
var facing_right: bool = false



func _unhandled_input(event: InputEvent) -> void:
    # TEMPORARY
    if not p.inp.verify_device(event):
        return

    for dir: StringName in dir_inputs.keys():
        if p.inp.event_is_action_just_pressed(event, dir):
            dir_inputs[dir] = true
        elif p.inp.event_is_action_just_released(event, dir):
            dir_inputs[dir] = false

    update_tilt()


func update_tilt() -> void:
    var pressed_dirs: Dictionary[Tilts, bool] = {
        Tilts.Forward: false,
        Tilts.Backward: false,
        Tilts.Up: false,
        Tilts.Down: false,
    }
    var dir_map: Dictionary[Tilts, StringName] = {
        Tilts.Forward: &"right" if facing_right else &"left",
        Tilts.Backward: &"left" if facing_right else &"right",
        Tilts.Up: &"up",
        Tilts.Down: &"down",
    }
    for tilt: Tilts in dir_map.keys():
        var dir: StringName = dir_map[tilt]
        if dir_inputs[dir]:
            pressed_dirs[tilt] = true

    var vert_value: int = (-1 if pressed_dirs[Tilts.Up] else 0) + (1 if pressed_dirs[Tilts.Down] else 0)
    var vert_neutral: bool = vert_value == 0
    current_tilt = Tilts.None if vert_neutral else (Tilts.Up if vert_value == -1 else Tilts.Down)
    if p.is_on_floor() and pressed_dirs[Tilts.Forward]:
        current_tilt = Tilts.Forward
    elif not p.is_on_floor() and pressed_dirs[Tilts.Backward]:
        current_tilt = Tilts.Backward

    DebugDraw2D.set_text("tilt", current_tilt)


func _ready() -> void:
    for c in get_children():
        c.free()
    await get_tree().physics_frame
    for a in attacks:
        var new_attack: Attack = a.scene.instantiate()
        add_child(new_attack)
        new_attack.started.connect(_on_attack_started)
        new_attack.bind = a.bind
        new_attack.p = p
        new_attack.ah = self
        new_attack.damage.connect(_on_attack_damage)

func _on_attack_damage(data: DamageData, body: Player) -> void:
    DebugDraw2D.set_text("hit", [body, data.health], 0, Color.WHITE, 0.2)

func _on_attack_started(anim_name: StringName) -> void:
    attack_started.emit(anim_name)
    p.state = Player.MoveState.None


func _on_sprites_animation_finished() -> void:
    if sprites.animation.begins_with("attack"):
        p.state = Player.MoveState.Both


func _on_horizontal_movement_flip(right: bool) -> void:
    if facing_right != right:
        facing_right = right
        update_tilt()

        for a: Attack in get_children():
            a.flip()
