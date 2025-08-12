extends Attack

const SPEED = 600.0

@export var vehicle_scene: PackedScene
#@export var data: DamageData
@export var health: int
@export var knockback: Vector2

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
    var data: DamageData = DamageData.new()
    data.health = health
    data.knockback = knockback
    data.knockback.x *= dir_mult()

    var new_vehicle: Projectile = vehicle_scene.instantiate()
    add_child(new_vehicle)
    new_vehicle.global_position = global_position
    new_vehicle.a = self
    new_vehicle.speed = SPEED
    new_vehicle.p = p
    new_vehicle.data = data
    new_vehicle.hit.connect(_on_vehicle_hit)
    in_vehicle = true

func _on_vehicle_hit(data: DamageData, body: Player) -> void:
    damage.emit(data, body)
