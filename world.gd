extends Node2D

@export var player_scene: PackedScene

var registered_devices: Array[int] = []

func _unhandled_input(event: InputEvent) -> void:
    var is_controller: bool = event is InputEventJoypadButton or event is InputEventJoypadMotion
    if event is InputEventKey and not registered_devices.has(-1):
        registered_devices.append(-1)
        spawn_player(-1)
    elif is_controller and not registered_devices.has(event.device):
        registered_devices.append(event.device)
        spawn_player(event.device)
        

func spawn_player(input_index: int) -> void:
    var new_player: Player = player_scene.instantiate()
    new_player.position = $SpawnPos.position
    new_player.input_index = input_index
    add_child(new_player)
#func _physics_process(delta: float) -> void:
    #%Cam.position.x = sin(Time.get_ticks_msec() / 500.0) * 100.0
