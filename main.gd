extends Node2D

var lobby_id: int = 0

func _ready() -> void:
    Steam.lobby_created.connect(_on_lobby_created)
    Steam.lobby_chat_update.connect(_on_lobby_chat_update)

    var initialize_response: Dictionary = Steam.steamInitEx(480, true)
    print("Did Steam initialize?: %s " % initialize_response)
    print(Steam.getPersonaName())

    Steam.createLobby(Steam.LOBBY_TYPE_PRIVATE, 2)

func _on_lobby_created(connect_id: int, this_lobby_id: int) -> void:
    if connect_id != 1:
        return

    lobby_id = this_lobby_id
    print("Created a lobby: %s" % lobby_id)

    Steam.setLobbyData(lobby_id, "name", "Shuflduf Gaming")
    Steam.setLobbyData(lobby_id, "mode", "GodotSteam test")

    var set_relay: bool = Steam.allowP2PPacketRelay(true)
    print("Allowing Steam to be relay backup: %s" % set_relay)

func _on_lobby_chat_update(_this_lobby_id: int, change_id: int, _making_change_id: int, chat_state: int) -> void:
    var changer_name: String = Steam.getFriendPersonaName(change_id)

    if chat_state == Steam.CHAT_MEMBER_STATE_CHANGE_ENTERED:
        print("%s has joined the lobby." % changer_name)

    elif chat_state == Steam.CHAT_MEMBER_STATE_CHANGE_LEFT:
        print("%s has left the lobby." % changer_name)

    elif chat_state == Steam.CHAT_MEMBER_STATE_CHANGE_KICKED:
        print("%s has been kicked from the lobby." % changer_name)

    elif chat_state == Steam.CHAT_MEMBER_STATE_CHANGE_BANNED:
        print("%s has been banned from the lobby." % changer_name)

    else:
        print("%s did... something." % changer_name)
