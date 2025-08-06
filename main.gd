extends Node2D

func _ready() -> void:
    Steam.avatar_loaded.connect(_on_loaded_avatar)

    Steam.steamInitEx(480, true)
    Steam.getPlayerAvatar()
    Steam.activateGameOverlayInviteDialog(0)

func _on_loaded_avatar(user_id: int, avatar_size: int, avatar_buffer: PackedByteArray) -> void:
    print("Avatar for user: %s" % user_id)
    print("Size: %s" % avatar_size)

    var avatar_image: Image = Image.create_from_data(avatar_size, avatar_size, false, Image.FORMAT_RGBA8, avatar_buffer)

    var avatar_texture: ImageTexture = ImageTexture.create_from_image(avatar_image)

    $Sprite.set_texture(avatar_texture)
