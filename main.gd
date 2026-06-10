extends Control

@onready var new_run_button = $CenterContainer/VBoxContainer/NewRunButton
@onready var continue_button = $CenterContainer/VBoxContainer/ContinueRunButton

func _ready():
	new_run_button.pressed.connect(_on_new_run_pressed)
	continue_button.pressed.connect(_on_continue_pressed)

func _on_new_run_pressed():
	get_tree().change_scene_to_file("res://scenes/new_run.tscn")

func _on_continue_pressed():
	get_tree().change_scene_to_file("res://scenes/run_select.tscn")
