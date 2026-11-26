SHIFTY THE WHALE

UI Design Framework — Documentation and Integration Guide

Project: Tech Club — Shifty the Whale
Contribution: UI Design Framework
Engine: Godot 4.x
Date: November 25, 2026
Development status: Independently tested; gameplay integration optional.

1. PURPOSE

This framework provides a reusable user interface for Shifty the Whale.

It is designed to allow developers to display gameplay information without having to build an entirely new interface or rewrite existing gameplay scripts.

The framework can be used in its entirety, partially incorporated, customized, or left unused according to the team's development needs.

2. DESIGN PRINCIPLES

Beginner-friendly implementation.

Modular and reusable components.

Optional interface features.

Separation between gameplay logic and visual presentation.

Independent testing without modifying the main game.

Compatibility with future gameplay features.

3. AVAILABLE FEATURES

Health:

Three heart icons.

Full and empty heart textures.

Numerical health display.

One heart represents one life.

Breath:

Four bubble icons.

Each bubble represents up to 25% breath.

Numerical percentage display.

Supports values between 0 and 100.

Score:

Displays a numerical score.

Prevents negative displayed values.

Timer:

Displays time in minutes and seconds.

Accepts time as a total number of seconds.

Objective:

Displays the player's current objective.

Status:

Displays the current gameplay status.

Pause:

Provides a signal requesting a pause.

Does not independently pause the game.

Visibility:

Individual interface features can be enabled or disabled through the Godot Inspector.

4. FILE STRUCTURE

01_UI_Design/
    Assets/
        FullHeart.png
        FullHeart.png.import
        EmptyHeart.png
        EmptyHeart.png.import
        FullBreath.png
        FullBreath.png.import
        EmptyBreath.png
        EmptyBreath.png.import

    Documentation/
        README_UI.txt

    Scenes/
        game_ui.tscn

    Scripts/
        game_ui.gd
        game_ui.gd.uid

99_DEV_TESTS/
    UI_Test/
        UI_Test.tscn
        ui_test.gd

Additional Godot-generated companion files may also be present.

Keep the original folder structure intact because the scripts reference assets through their project resource paths.

5. UNDERSTANDING THE FILES

game_ui.tscn

Contains the visual interface, labels, containers, and icon placement.

game_ui.gd

Controls the displayed information and provides functions that other gameplay scripts can call.

Assets

Contains the illustrated heart and breath icons.

.png.import

Contains Godot's asset import configuration.

.gd.uid

Contains the persistent identifier Godot uses to reference a script.

UI_Test.tscn

An independent testing scene that demonstrates the framework.

ui_test.gd

Simulates gameplay information for testing purposes.

README_UI.txt

Explains installation, customization, testing, and integration.

6. UNDERSTANDING HOW THE FRAMEWORK WORKS

The interface displays information supplied by gameplay systems.

It does not independently calculate damage, consume breath, award points, or determine victory and defeat.

The intended flow is:

Gameplay event
      |
      v
Gameplay variable changes
      |
      v
UI update function is called
      |
      v
Interface displays the new value

For example:

Player receives damage
      |
      v
Player health decreases
      |
      v
update_health(health)
      |
      v
Heart icons and health label update

This separation allows gameplay developers to change their mechanics without rebuilding the interface.

7. INSTALLATION

If the framework is already present in the main Godot project, no additional copying is required.

Otherwise:

Locate the folder containing project.godot.

Copy the complete 01_UI_Design folder into that directory.

Copy UI_Test into the existing 99_DEV_TESTS folder.

Preserve all existing team files and testing modules.

Open the project in Godot.

Allow Godot to import the assets.

Do not replace the team's existing project.godot, player scripts, main game scene, or game-over interface.

8. INDEPENDENT TESTING

Before integrating the framework:

Open the Godot project.

Locate:

res://99_DEV_TESTS/UI_Test/UI_Test.tscn

Double-click the scene.

Press F6 to run the current scene.

F6 runs the selected scene independently.

F5 runs the project's configured main scene.

The testing module does not require the main gameplay scene to function.

9. TESTING CONTROLS

Key

Test

Expected result

H

Decrease health

One heart becomes empty

J

Restore health

One heart becomes full

B

Decrease breath

Breath decreases by 25%

N

Restore breath

Breath increases by 25%

C

Increase score

Score increases by 10

T

Increase timer

Time increases by 10 seconds

O

Change objective

Objective text changes

P

Request pause

Status changes and signal is reported

R

Reset

Starting values are restored

Expected starting values:

Health: 3 / 3

Breath: 100%

Score: 0

Time: 00:00

Objective: Reach the exit

Status: Playing

All nine visual control tests passed during independent development testing.

10. ADDITIONAL BOUNDARY TESTING

Recommended checks:

Press H repeatedly until health reaches zero.

Confirm health does not decrease below zero.

Press J repeatedly and confirm health does not exceed three.

Press B repeatedly until breath reaches zero.

Confirm breath does not decrease below zero.

Press N repeatedly and confirm breath does not exceed 100%.

Press T until the timer passes one minute.

Confirm that the timer displays minutes and seconds correctly.

These checks are recommended for additional verification.

11. ADDING THE UI TO THE MAIN GAME

Open the team's main gameplay scene.

For example:

res://scenes/game.tscn

Locate game_ui.tscn in the FileSystem panel.

Drag it into the main scene's Scene Tree.

Place it beneath the main gameplay root.

Confirm that the instance is named GameUI.

Save the scene.

The expected simplified structure is:

Game
    Player
    Environment
    GameUI
        Control
        MarginContainer

The actual main scene may contain additional nodes.

GameUI uses a CanvasLayer to display the interface independently of the moving gameplay camera.

The Control node contains the interface controller script.

12. CUSTOMIZING FEATURE VISIBILITY

Select the Control node inside GameUI.

Locate the UI Visibility section in the Inspector.

The available settings are:

Show Health

Show Breath

Show Score

Show Timer

Show Objective

Show Status

Checked means the feature is visible.

Unchecked means the feature is hidden.

For example, if breath has not been implemented, uncheck Show Breath.

If the team prefers its existing animated heart display, uncheck Show Health.

This allows both systems to coexist without displaying duplicate health interfaces.

Visibility settings are applied when the interface initializes.

If visibility variables are changed through code during gameplay, call:

apply_visibility_settings()

on the UI controller to apply the changes.

13. CONNECTING GAMEPLAY SCRIPTS

Gameplay scripts must obtain a reference to the UI controller before calling its functions.

For example, if Player and GameUI are siblings:

@onready var ui = get_node_or_null("../GameUI/Control")

Understanding this line:

@onready

Waits until the node is entering its ready stage before assigning the reference.

get_node_or_null()

Attempts to locate a node without producing a missing-node error when the path is unavailable.

../

Moves one level upward in the Scene Tree.

GameUI/Control

Identifies the interface controller.

The path must be adjusted if the team's Scene Tree is organized differently.

Important:

A node reference does not guarantee that the referenced interface has completed its own initialization.

Perform initial synchronization after GameUI is ready. A main scene controller or deferred initialization can help coordinate this.

14. CONNECTING THE HEALTH SYSTEM

The team's existing player script may already contain:

var health = 3

and a damage function.

The existing gameplay logic should remain responsible for changing health.

An example integration is:

func take_damage():
    if health > 0:
        health -= 1
        update_heart_display()

        if is_instance_valid(ui):
            ui.update_health(health)

This example assumes the UI reference has already been assigned and the interface is ready.

The existing update_heart_display() function is preserved.

The new UI receives the current health value rather than calculating damage independently.

If the team chooses to replace its existing visual health display, that should be a separate team-approved change.

15. CONNECTING OPTIONAL GAMEPLAY FEATURES

Only connect features that are required by the game.

BREATH

if is_instance_valid(ui):
    ui.update_breath(breath)

The gameplay system determines how breath is consumed and restored.

The interface displays the supplied value.

SCORE

if is_instance_valid(ui):
    ui.update_score(score)

The gameplay system determines how points are awarded.

TIMER

if is_instance_valid(ui):
    ui.update_timer(int(elapsed_time))

The gameplay system determines how time progresses.

The interface converts the supplied seconds into minutes and seconds.

OBJECTIVE

if is_instance_valid(ui):
    ui.update_objective("Find the next passage")

STATUS

if is_instance_valid(ui):
    ui.update_status("Playing")

The variables breath, score, and elapsed_time are examples. They must exist in the gameplay script before these examples can be used.

16. AVAILABLE UI FUNCTIONS

Function

Purpose

update_health(value)

Updates health icons and numerical health

update_breath(value)

Updates breath icons and percentage

update_score(value)

Updates displayed score

update_timer(seconds)

Updates displayed time

update_objective(message)

Changes objective text

update_status(message)

Changes status text

apply_visibility_settings()

Applies feature visibility settings

request_pause()

Emits the pause request signal

These functions update the visual interface.

They should not be treated as replacements for gameplay mechanics.

17. CONNECTING THE WIN/LOSS FRAMEWORK

The separately contributed Win/Loss framework is located in:

res://02_WinLoss/

Its documentation is located in:

res://02_WinLoss/Documentation/README_WinLoss.txt

The manager provides the following signals:

game_won(reason)
game_lost(reason)
round_finished(won, reason)

The UI can respond to these signals by changing its status and objective text.

Example signal handlers:

func _on_game_won(reason: String):
    if is_instance_valid(ui):
        ui.update_status("Victory")
        ui.update_objective(reason)

func _on_game_lost(reason: String):
    if is_instance_valid(ui):
        ui.update_status("Defeat")
        ui.update_objective(reason)

These handlers must be connected to the actual Win/Loss manager signals before they will execute.

The Win/Loss manager determines the outcome.

The UI displays the outcome.

The team's existing game-over interface may continue handling restart buttons, menus, and other game-over behavior.

Do not replace game_over_ui.gd or existing game-over systems simply to use this framework.

18. PAUSE REQUEST SIGNAL

The interface provides:

signal pause_requested

Calling:

ui.request_pause()

emits this signal.

A gameplay controller may connect to the signal:

ui.pause_requested.connect(_on_pause_requested)

An example response is:

func _on_pause_requested():
    get_tree().paused = true

This is an optional implementation example.

Before enabling actual pausing, the team must provide a working resume mechanism and configure the appropriate menu nodes to process while the game is paused.

Otherwise, the player may become unable to resume gameplay.

The independent UI test verifies signal communication only. It does not pause the entire game.

19. TROUBLESHOOTING

PROBLEM: UI does not appear.

Check:

GameUI is instanced in the correct scene.

The relevant visibility settings are enabled.

The correct scene is running.

PROBLEM: Node not found.

Check:

The node names match the script references.

The relative node path is correct.

GameUI and its Control node exist.

PROBLEM: Invalid access or null reference.

Check:

The UI controller reference was assigned.

The interface has completed initialization.

The UI instance has not been removed.

PROBLEM: Missing textures.

Check:

All four PNG assets exist.

The original folder structure was preserved.

Asset filenames and capitalization match the script.

PROBLEM: Health or breath does not change.

Check:

Gameplay variables are actually changing.

The appropriate UI update function is being called.

The supplied value uses the expected range.

Health: 0–3.

Breath: 0–100.

PROBLEM: Two health interfaces appear.

The existing animated health display and the contributed health display may both be enabled.

Disable the contributed health display through Show Health if the team wishes to retain its existing interface.

PROBLEM: Pause request does not pause gameplay.

This is expected unless a gameplay controller has been connected to the pause_requested signal.

PROBLEM: F5 launches the main game instead of the UI test.

Open UI_Test.tscn and press F6.

20. INTEGRATION CHECKLIST

Original team files preserved.

UI assets imported successfully.

Independent UI testing scene opens.

All nine testing controls function.

Additional boundary tests completed.

Required interface features enabled.

Unused interface features disabled.

Gameplay variables connected correctly.

No duplicate health displays.

Existing game-over interface preserved.

Pause and resume behavior verified if implemented.

Main gameplay scene tested after integration.

Changes reviewed before committing.

21. CURRENT LIMITATIONS

The framework is a visual presentation system.

It does not independently provide:

Damage calculations.

Breath consumption mechanics.

Enemy behavior.

Player movement.

Score rewards.

Automatic timer progression.

Objective completion detection.

Victory or defeat determination.

Restart or resume menus.

These responsibilities belong to their respective gameplay systems.

The integration examples are instructional and must be adapted to the team's current scene structure and gameplay scripts.

Independent testing has been completed. Full integration with the latest main gameplay scene has not been verified.

22. FINAL DEVELOPMENT NOTES

This contribution is intended to support the team's development rather than dictate its final design.

Developers are encouraged to reuse individual features, modify the visual presentation, or retain their existing gameplay interfaces where appropriate.

The framework and its independent testing module can remain in the project without being incorporated into the main gameplay scene.

End of documentation.