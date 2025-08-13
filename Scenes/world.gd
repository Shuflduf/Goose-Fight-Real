extends Node2D

@export var player_scene: PackedScene
@export var health_indicator_scene: PackedScene

var registered_devices: Array[int] = []

func _physics_process(_delta: float) -> void:
    var positions: Array = $Players.get_children().map(
        func(p: Player) -> Vector2:
            return p.position
    )
    positions.append($CenterPos.position)

    var average: Vector2 = positions.reduce(
        func(accum: Vector2, v: Vector2) -> Vector2:
            return accum + v
    ) / positions.size()

    %Cam.position = average - $CenterPos.position + Vector2(0.0, -80.0)

func _unhandled_input(event: InputEvent) -> void:
    var is_controller: bool = event is InputEventJoypadButton or event is InputEventJoypadMotion
    if event is InputEventKey and not registered_devices.has(-1):
        registered_devices.append(-1)
        spawn_player(-1)
    elif is_controller and not registered_devices.has(event.device):
        registered_devices.append(event.device)
        spawn_player(event.device)

    if event.is_action_pressed(&"dummy"):
        spawn_player(10000)


func spawn_player(input_index: int) -> void:
    var new_player: Player = player_scene.instantiate()
    new_player.position = $SpawnPos.position
    new_player.input_index = input_index
    new_player.scheme = randi_range(0, ColorMap.VisualScheme.Max - 1) as ColorMap.VisualScheme

    $Players.add_child(new_player)

    var new_health_indic: HealthIndicator = health_indicator_scene.instantiate()
    new_health_indic.scheme = new_player.scheme
    %Indicators.add_child(new_health_indic)
    new_player.health_indicator = new_health_indic
    # make sure to set the color scheme here


#func _physics_process(delta: float) -> void:
    #%Cam.position.x = sin(Time.get_ticks_msec() / 500.0) * 100.0
