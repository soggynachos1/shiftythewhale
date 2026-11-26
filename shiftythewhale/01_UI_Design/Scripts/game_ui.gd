
extends Control

# ==========================================
# SIGNALS
# ==========================================

signal pause_requested


# ==========================================
# UI VISIBILITY SETTINGS
# ==========================================

@export_group("UI Visibility")

@export var show_health: bool = true
@export var show_breath: bool = true
@export var show_score: bool = true
@export var show_timer: bool = true
@export var show_objective: bool = true
@export var show_status: bool = true


# ==========================================
# IMAGE ASSETS
# ==========================================

const FULL_HEART = preload("res://01_UI_Design/Assets/FullHeart.png")
const EMPTY_HEART = preload("res://01_UI_Design/Assets/EmptyHeart.png")

const FULL_BREATH = preload("res://01_UI_Design/Assets/FullBreath.png")
const EMPTY_BREATH = preload("res://01_UI_Design/Assets/EmptyBreath.png")

# ==========================================
# ICON SETTINGS
# ==========================================

const ICON_SIZE := Vector2(40, 40)


# ==========================================
# NODE REFERENCES
# Script attached to Control.
# ==========================================

@onready var score_label: Label = $"../MarginContainer/VBoxContainer/ScoreLabel"
@onready var timer_label: Label = $"../MarginContainer/VBoxContainer/TimerLabel"
@onready var objective_label: Label = $"../MarginContainer/VBoxContainer/ObjectiveLabel"
@onready var status_label: Label = $"../MarginContainer/VBoxContainer/StatusLabel"

# Health row
@onready var health_label: Label = $"../MarginContainer/VBoxContainer/HealthRow/HealthLabel"
@onready var health_container: HBoxContainer = $"../MarginContainer/VBoxContainer/HealthRow/HealthContainer"

# Breath row
@onready var breath_label: Label = $"../MarginContainer/VBoxContainer/BreathRow/BreathLabel"
@onready var breath_container: HBoxContainer = $"../MarginContainer/VBoxContainer/BreathRow/BreathContainer"


# ==========================================
# INITIALIZATION
# ==========================================

func _ready() -> void:

	configure_all_icons()
	apply_visibility_settings()

	update_score(0)
	update_timer(0)

	update_objective("Reach the exit")
	update_status("Playing")

	update_health(3)
	update_breath(100)


# ==========================================
# APPLY UI VISIBILITY SETTINGS
# ==========================================

func apply_visibility_settings() -> void:

	health_container.get_parent().visible = show_health
	breath_container.get_parent().visible = show_breath

	score_label.visible = show_score
	timer_label.visible = show_timer
	objective_label.visible = show_objective
	status_label.visible = show_status


# ==========================================
# ICON CONFIGURATION
# ==========================================

func configure_icon(icon: TextureRect) -> void:

	icon.custom_minimum_size = ICON_SIZE
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED


func configure_all_icons() -> void:

	for icon in health_container.get_children():

		if icon is TextureRect:
			configure_icon(icon)

	for icon in breath_container.get_children():

		if icon is TextureRect:
			configure_icon(icon)


# ==========================================
# SCORE DISPLAY
# ==========================================

func update_score(value: int) -> void:

	score_label.text = "Score: %d" % maxi(value, 0)


# ==========================================
# TIMER DISPLAY
# Input: Seconds
# ==========================================

func update_timer(seconds: int) -> void:

	var safe_seconds: int = maxi(seconds, 0)

	var minutes: int = floori(float(safe_seconds) / 60.0)
	var remaining_seconds: int = safe_seconds % 60

	timer_label.text = "Time: %02d:%02d" % [
		minutes,
		remaining_seconds
	]


# ==========================================
# OBJECTIVE DISPLAY
# ==========================================

func update_objective(message: String) -> void:

	objective_label.text = "Objective: " + message


# ==========================================
# STATUS DISPLAY
# ==========================================

func update_status(message: String) -> void:

	status_label.text = "Status: " + message


# ==========================================
# HEALTH DISPLAY
# Four lives maximum.
# One heart represents one life.
# Input: 0 to 4
# ==========================================

func update_health(value: int) -> void:

	var maximum_lives: int = health_container.get_child_count()

	var current_lives: int = clampi(
		value,
		0,
		maximum_lives
	)

	health_label.text = "Health: %d / %d" % [
		current_lives,
		maximum_lives
	]

	for i in range(maximum_lives):

		var health_icon = health_container.get_child(i)

		if health_icon is TextureRect:

			health_icon.texture = (
				FULL_HEART if i < current_lives
				else EMPTY_HEART
			)


# ==========================================
# BREATH DISPLAY
# Four bubbles represent 100%.
# Input: 0 to 100
# ==========================================

func update_breath(value: int) -> void:

	var current_breath: int = clampi(value, 0, 100)

	breath_label.text = "Breath: %d%%" % current_breath

	var maximum_icons: int = breath_container.get_child_count()

	var active_icons: int = ceili(
		float(current_breath) / 25.0
	)

	active_icons = clampi(
		active_icons,
		0,
		maximum_icons
	)

	for i in range(maximum_icons):

		var breath_icon = breath_container.get_child(i)

		if breath_icon is TextureRect:

			breath_icon.texture = (
				FULL_BREATH if i < active_icons
				else EMPTY_BREATH
			)


# =============a=============================
# PAUSE REQUEST
# ==========================================

func request_pause() -> void:

	pause_requested.emit()
