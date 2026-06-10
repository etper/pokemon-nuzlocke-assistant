extends PanelContainer

@onready var game_label = $MarginContainer/VBoxContainer/GameLabel
@onready var badge_label = $MarginContainer/VBoxContainer/HBoxContainer/BadgeLabel
@onready var alive_label = $MarginContainer/VBoxContainer/HBoxContainer/AliveLabel
@onready var dead_label = $MarginContainer/VBoxContainer/HBoxContainer/DeadLabel

func setup(run_data: Dictionary):
	game_label.text = run_data.game
	badge_label.text = "Badges: %d" % run_data.badges
	alive_label.text = "Alive: %d" % run_data.alive_count
	dead_label.text = "Dead: %d" % run_data.dead_count
