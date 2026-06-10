extends PanelContainer

signal open_requested(run_id)

@onready var game_label: Label = $MarginContainer/VBoxContainer/GameLabel
@onready var badge_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/BadgeLabel
@onready var alive_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/AliveLabel
@onready var dead_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/DeadLabel
@onready var open_button: Button = $MarginContainer/VBoxContainer/OpenButton

var run_id: String = ""

func _ready() -> void:
	open_button.pressed.connect(_on_open_pressed)

func setup(run_data: Dictionary) -> void:
	if run_data.is_empty():
		return

	run_id = str(run_data.get("id", ""))

	game_label.text = str(run_data.get("game", "Unknown"))
	badge_label.text = "Badges: %d" % int(run_data.get("badges", 0))
	alive_label.text = "Alive: %d" % int(run_data.get("alive_count", 0))
	dead_label.text = "Dead: %d" % int(run_data.get("dead_count", 0))

func _on_open_pressed() -> void:
	open_requested.emit(run_id)
