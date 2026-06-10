extends Control

@onready var new_run_button = $CenterContainer/VBoxContainer/NewRunButton
@onready var continue_button = $CenterContainer/VBoxContainer/ContinueRunButton

const SAVE_DIR := "user://runs/"
const RUN_CARD_SCENE := preload("res://RunCard.tscn")

@onready var runs_container = $ScrollContainer/RunsContainer

func _on_new_run_button_pressed() -> void:
	var run_id := str(Time.get_unix_time_from_system())

	var run_data := {
		"id": run_id,
		"game": "Emerald",
		"badges": 0,
		"alive_count": 0,
		"dead_count": 0
	}

	save_run(run_data)

	print("Created run: ", run_id)

func _on_continue_run_button_pressed() -> void:
	show_saved_runs()

func save_run(run_data: Dictionary) -> void:
	DirAccess.make_dir_recursive_absolute(SAVE_DIR)

	var path: String = SAVE_DIR + str(run_data["id"]) + ".json"

	var file := FileAccess.open(path, FileAccess.WRITE)

	if file:
		file.store_string(JSON.stringify(run_data))
		file.close()

func load_runs() -> Array:
	var runs: Array = []

	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		return runs

	var dir := DirAccess.open(SAVE_DIR)

	if dir == null:
		return runs

	dir.list_dir_begin()

	var file_name := dir.get_next()

	while file_name != "":
		if file_name.ends_with(".json"):
			var file := FileAccess.open(
				SAVE_DIR + file_name,
				FileAccess.READ
			)

			if file:
				var json_text := file.get_as_text()

				var parsed = JSON.parse_string(json_text)

				if parsed is Dictionary:
					runs.append(parsed)

		file_name = dir.get_next()

	dir.list_dir_end()

	return runs

func show_saved_runs() -> void:
	for child in runs_container.get_children():
		child.queue_free()

	var runs := load_runs()

	for run_data in runs:
		var card = RUN_CARD_SCENE.instantiate()

		runs_container.add_child(card)

		card.setup(run_data)

		card.open_requested.connect(_on_run_open_requested)

func _on_run_open_requested(run_id: String) -> void:
	var run_data = load_run(run_id)

	if run_data.is_empty():
		return

	RunManager.current_run = run_data

	get_tree().change_scene_to_file("res://RunView.tscn")

func load_run(run_id: String) -> Dictionary:
	var path := SAVE_DIR + run_id + ".json"

	if not FileAccess.file_exists(path):
		return {}

	var file := FileAccess.open(path, FileAccess.READ)

	if file == null:
		return {}

	var parsed = JSON.parse_string(file.get_as_text())

	if parsed is Dictionary:
		return parsed

	return {}
