
extends Control

# ==========================================
# SIMULATED GAMEPLAY VALUES
# ==========================================

var health: int = 3
var breath: int = 100
var score: int = 0
var elapsed_time: int = 0

var objective: String = "Reach the exit"
var status: String = "Playing"

# Reference to the original UI controller.
@onready var ui = get_node_or_null("GameUI/Control")


# ==========================================
# INITIALIZATION
# ==========================================

func _ready() -> void:
	if ui == null:
		push_error("UI controller not found.")
		return

	ui.pause_requested.connect(_on_pause_requested)

	refresh_ui()

	print("UI Testing Module Ready")
	print("UI Controller Connected")
	print("H/J: Health | B/N: Breath")
	print("C: Score | T: Timer | O: Objective")
	print("P: Pause Request | R: Reset")


# ==========================================
# KEYBOARD TEST CONTROLS
# ==========================================

func _input(event: InputEvent) -> void:
	if ui == null:
		return

	if event is InputEventKey:
		if event.pressed and not event.echo:
			match event.keycode:

				KEY_H:
					health = maxi(health - 1, 0)

				KEY_J:
					health = mini(health + 1, 3)

				KEY_B:
					breath = maxi(breath - 25, 0)

				KEY_N:
					breath = mini(breath + 25, 100)

				KEY_C:
					score += 10

				KEY_T:
					elapsed_time += 10

				KEY_O:
					objective = "Find the next passage"

				KEY_P:
					ui.request_pause()

				KEY_R:
					reset_test()

				_:
					return

			refresh_ui()


# ==========================================
# UPDATE UI DISPLAY
# ==========================================

func refresh_ui() -> void:
	ui.update_health(health)
	ui.update_breath(breath)
	ui.update_score(score)
	ui.update_timer(elapsed_time)
	ui.update_objective(objective)
	ui.update_status(status)


# ==========================================
# PAUSE SIGNAL TEST
# ==========================================

func _on_pause_requested() -> void:
	status = "Pause requested"
	print("Pause signal received successfully")


# ==========================================
# RESET TEST VALUES
# ==========================================

func reset_test() -> void:
	health = 3
	breath = 100
	score = 0
	elapsed_time = 0
	objective = "Reach the exit"
	status = "Playing"

	print("UI Test Reset")
