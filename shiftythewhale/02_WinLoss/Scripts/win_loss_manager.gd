
extends Node

# ==========================================
# SIGNALS
# ==========================================

signal game_won(reason: String)
signal game_lost(reason: String)
signal round_finished(won: bool, reason: String)


# ==========================================
# GAME OUTCOME
# ==========================================

enum Outcome {
	NONE,
	WIN,
	LOSS
}

var current_outcome: Outcome = Outcome.NONE

var result_reason: String = ""


# ==========================================
# STATE CHECKS
# ==========================================

func is_game_finished() -> bool:

	return current_outcome != Outcome.NONE


func has_won() -> bool:

	return current_outcome == Outcome.WIN


func has_lost() -> bool:

	return current_outcome == Outcome.LOSS


# ==========================================
# VICTORY TRIGGER
# ==========================================

func trigger_win(reason: String = "Victory condition met") -> void:

	if is_game_finished():
		return

	current_outcome = Outcome.WIN
	result_reason = reason

	print("GAME WON: ", reason)

	game_won.emit(reason)
	round_finished.emit(true, reason)


# ==========================================
# DEFEAT TRIGGER
# ==========================================

func trigger_loss(reason: String = "Defeat condition met") -> void:

	if is_game_finished():
		return

	current_outcome = Outcome.LOSS
	result_reason = reason

	print("GAME LOST: ", reason)

	game_lost.emit(reason)
	round_finished.emit(false, reason)


# ==========================================
# RESET GAME STATE
# ==========================================

func reset_round() -> void:

	current_outcome = Outcome.NONE
	result_reason = ""

	print("GAME RESET: Ready for a new round.")


# ==========================================
# DEBUG INFORMATION
# ==========================================

func get_outcome_name() -> String:

	match current_outcome:

		Outcome.WIN:
			return "WIN"

		Outcome.LOSS:
			return "LOSS"

		_:
			return "NONE"
