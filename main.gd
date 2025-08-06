extends Node2D

func _ready() -> void:
    var initialize_response: Dictionary = Steam.steamInitEx()
    print("Did Steam initialize?: %s " % initialize_response)
    print(Steam.getPersonaName())
