
extends Node

# ==========================================
# TEMPORARY TEST MODULE
# ==========================================

const WIN_LOSS_MANAGER = preload(
	"res://02_WinLoss/Scripts/win_loss_manager.gd"
)

var manager


# ==========================================
# INITIALIZATION
# ==========================================

func _ready() -> void:

	manager = WIN_LOSS_MANAGER.new()

	add_child(manager)

	manager.game_won.connect(_on_game_won)
	manager.game_lost.connect(_on_game_lost)
	manager.round_finished.connect(_on_round_finished)

	print("--------------------------------")
	print("WIN / LOSS TEST MODULE")
	print("--------------------------------")
	print("Press W = Test Victory")
	print("Press L = Test Defeat")
	print("Press R = Reset Round")
	print("--------------------------------")


# ==========================================
# TEST CONTROLS
# ==========================================

func _unhandled_key_input(event: InputEvent) -> void:

	if not event is InputEventKey:
		return

	if not event.pressed or event.echo:
		return

	match event.keycode:

		KEY_W:
			manager.trigger_win("Player reached the exit.")

		KEY_L:
			manager.trigger_loss("Player ran out of lives.")

		KEY_R:
			manager.reset_round()


# ==========================================
# SIGNAL RESPONSES
# ==========================================

func _on_game_won(reason: String) -> void:

	print("TEST RESULT: VICTORY")
	print("Reason: ", reason)


func _on_game_lost(reason: String) -> void:

	print("TEST RESULT: DEFEAT")
	print("Reason: ", reason)


func _on_round_finished(won: bool, reason: String) -> void:

	print("ROUND FINISHED")
	print("Victory: ", won)
	print("Reason: ", reason)
