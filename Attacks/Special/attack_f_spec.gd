extends Attack

const SPEED = 600.0

@export var vehicle_scene: PackedScene

var in_vehicle: bool = false

func _unhandled_input(event: InputEvent) -> void:
    super(event)
    if p.inp.event_is_action_just_pressed(event, &"jump"):
        leave()

func leave(jump: bool = true) -> void:
    if not in_vehicle:
        return

    finished_early.emit()
    in_vehicle = false
    if jump:
        # this is surely a good idea
        p.position.y -= 20.0

func _physics_process(_delta: float) -> void:
    if in_vehicle:
        p.velocity.x = -SPEED * dir_mult()
        if not p.is_on_floor():
            leave(false)

func spawn_vehicle() -> void:
    var new_vehicle: FSpecVehicle = vehicle_scene.instantiate()
    add_child(new_vehicle)
    new_vehicle.global_position = global_position
    new_vehicle.a = self
    new_vehicle.speed = SPEED
    in_vehicle = true
