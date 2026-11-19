extends Node #I think this will connect to the node
#that will be use dfor 
#the backgorund im assuming(?)

signal phase_changed(is_dimension_a: bool)

@onready var dimension_a: TileMapLayer = $DimensionA
@onready var dimension_b: TileMapLayer = $DimensionB

var is_dimension_a_active: bool = true

func _ready() -> void:
	_update_dimension_state()
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shift_phase"):
		is_dimension_a_active = !is_dimension_a_active
		_update_dimension_state()
		phase_changed.emit(is_dimension_a_active)
func update_dimension_state() -> void:
	dimension_a.visibile = is_dimension_a_active
	dimension_a.enabled = is_dimension_a_active
	dimension_b.visibile = !is_dimension_a_active
	dimension_b.enabled = is_dimension_a_active
	
