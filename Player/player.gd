class_name Player
extends CharacterBody2D

@onready var inp: InputHandler = $InputHandler
@onready var hmove: PHorizMovement = $HorizontalMovement
@onready var vmove: PVertMovement = $VerticalMovement
@onready var hit_handler: PHitHandler = $HitHandler
@onready var wall_jump: PWallJumps = $WallJump


@export var input_index: int = -1
@export var color_map: ColorMap
@export var scheme: ColorMap.VisualScheme
@export var health_indicator: HealthIndicator

enum MoveState {
    Both,
    VertOnly,
    Stunned,
    None,
}

var state: MoveState = MoveState.Both
var health: int = 0

func _physics_process(_delta: float) -> void:
    move_and_slide()

func _ready() -> void:
    var change_material: ShaderMaterial = %Sprites.material
    var new_colors: ColorScheme = color_map.color_map[scheme]
    change_material.set_shader_parameter(&"base", new_colors.base)
    change_material.set_shader_parameter(&"secondary", new_colors.secondary)

func hit(data: DamageData) -> void:
    hit_handler.process_hit(data)
