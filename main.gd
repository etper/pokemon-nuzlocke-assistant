extends Control

@onready var new_run_button = $CenterContainer/VBoxContainer/NewRunButton
@onready var continue_button = $CenterContainer/VBoxContainer/ContinueRunButton

func _on_new_run_button_pressed() -> void:
	print("New Run")


func _on_continue_run_button_pressed() -> void:
	print("Continue Run")
