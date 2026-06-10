extends PanelContainer

signal open_requested(run_id)

@onready var game_label = $MarginContainer/VBoxContainer/GameLabel
@onready var badge_label = $MarginContainer/VBoxContainer/HBoxContainer/BadgeLabel
@onready var alive_label = $MarginContainer/VBoxContainer/HBoxContainer/AliveLabel
@onready var dead_label = $MarginContainer/VBoxContainer/HBoxContainer/DeadLabel
@onready var open_button = $MarginContainer/VBoxContainer/OpenButton

var run_id: String

func _ready() -> void:
	open_button.pressed.connect(_on_open_pressed)

func setup(run_data: Dictionary) -> void:
	run_id = run_data["id"]

	game_label.text = run_data["game"]
	badge_label.text = "Badges: %d" % run_data["badges"]
	alive_label.text = "Alive: %d" % run_data["alive_count"]
	dead_label.text = "Dead: %d" % run_data["dead_count"]

func _on_open_pressed() -> void:
	open_requested.emit(run_id)
