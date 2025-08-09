extends Attack

@onready var pepsi_pos: float = $PepsiParent.position.x

func flip() -> void:
    $PepsiParent.position.x = pepsi_pos * dir_mult()
