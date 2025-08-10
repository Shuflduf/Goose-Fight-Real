class_name HealthIndicator
extends Control

@export var color_map: ColorMap
@export var scheme: ColorMap.VisualScheme

var value: int = 0:
    set(new):
        value = new
        $Bar.value = value
        %Label.text = str(new) + "%"

func _ready() -> void:
    value = value
    var change_material: ShaderMaterial = %Texture.material
    var new_colors: ColorScheme = color_map.color_map[scheme]
    change_material.set_shader_parameter(&"base", new_colors.base)
    change_material.set_shader_parameter(&"secondary", new_colors.secondary)
