extends Control

func _ready() -> void:
	setup(RunManager.current_run)

func setup(data: Dictionary) -> void:
	$GameLabel.text = str(data.get("game", "Unknown"))
	$BadgeLabel.text = "Badges: %d" % int(data.get("badges", 0))
