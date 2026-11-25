extends Node2D

signal phase_changed(is_dimension_a: bool)

@onready var dimension_a: TileMapLayer = $sea_tilemap
@onready var dimension_b: TileMapLayer = $dimension_changed

var is_dimension_a_active: bool = true

func _ready() -> void:
	_update_dimension_state()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift_dimension"):
		is_dimension_a_active = !is_dimension_a_active
		_update_dimension_state()
		phase_changed.emit(is_dimension_a_active)

func _update_dimension_state() -> void:
	dimension_a.visible = is_dimension_a_active
	dimension_a.enabled = is_dimension_a_active
	dimension_b.visible = !is_dimension_a_active
	dimension_b.enabled = !is_dimension_a_active
	
	
	
