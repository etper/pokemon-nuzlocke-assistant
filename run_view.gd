extends Control

const EncounterData = preload("res://encounter_data.gd")

@onready var encounter_list = $ScrollContainer/EncounterList

@onready var team_list = $VBoxContainer/TeamList
@onready var graveyard_list = $VBoxContainer/GraveyardList

func _ready() -> void:
	setup(RunManager.current_run)

func setup(data: Dictionary) -> void:

	$GameLabel.text = str(
		data.get("game", "Unknown")
	)

	$BadgeLabel.text = "Badges: %d" % int(
		data.get("badges", 0)
	)

	build_encounters(data)

	refresh_team_views()

func build_encounters(run_data: Dictionary):

	for child in encounter_list.get_children():
		child.queue_free()

	var routes = EncounterData.get_routes(
		run_data["game"]
	)

	for route_name in routes.keys():

		var route_box := VBoxContainer.new()

		var title := Label.new()
		title.text = route_name

		route_box.add_child(title)

		for pokemon in routes[route_name]:

			var button := CheckBox.new()

			button.text = pokemon

			var caught = (
				run_data
				.get("encounters", {})
				.get(route_name, {})
				.get("caught", null)
			)

			button.button_pressed = (
				caught == pokemon
			)

			button.pressed.connect(
				func():
					select_pokemon(
						route_name,
						pokemon
					)
			)

			route_box.add_child(button)

		encounter_list.add_child(route_box)

func select_pokemon(
	route_name: String,
	pokemon: String
):

	if not RunManager.current_run.has(
		"encounters"
	):
		RunManager.current_run["encounters"] = {}

	RunManager.current_run["encounters"][route_name] = {
		"caught": pokemon,
		"nickname": "",
		"status": "alive"
	}

	if not pokemon in RunManager.current_run["team"]:
		RunManager.current_run["team"].append(
			pokemon
		)

	RunManager.current_run["alive_count"] = (
		RunManager.current_run["team"].size()
	)

	RunManager.current_run["dead_count"] = (
		RunManager.current_run["graveyard"].size()
	)

	RunManager.save_current_run()

	get_tree().reload_current_scene()

func refresh_team_views():

	for child in team_list.get_children():
		child.queue_free()

	for child in graveyard_list.get_children():
		child.queue_free()

	for pokemon in RunManager.current_run.get("team", []):

		var row := HBoxContainer.new()

		var label := Label.new()
		label.text = pokemon

		var kill_button := Button.new()
		kill_button.text = "☠"

		kill_button.pressed.connect(
			func():
				kill_pokemon(pokemon)
		)

		row.add_child(label)
		row.add_child(kill_button)

		team_list.add_child(row)

	for pokemon in RunManager.current_run.get("graveyard", []):

		var row := HBoxContainer.new()

		var label := Label.new()
		label.text = pokemon

		var revive_button := Button.new()
		revive_button.text = "↺"

		revive_button.pressed.connect(
			func():
				revive_pokemon(pokemon)
		)

		row.add_child(label)
		row.add_child(revive_button)

		graveyard_list.add_child(row)

func kill_pokemon(pokemon: String):

	RunManager.current_run["team"].erase(
		pokemon
	)

	if not pokemon in RunManager.current_run["graveyard"]:
		RunManager.current_run["graveyard"].append(
			pokemon
		)

	RunManager.current_run["alive_count"] = (
		RunManager.current_run["team"].size()
	)

	RunManager.current_run["dead_count"] = (
		RunManager.current_run["graveyard"].size()
	)

	RunManager.save_current_run()

	refresh_team_views()

func revive_pokemon(pokemon: String):

	RunManager.current_run["graveyard"].erase(
		pokemon
	)

	if not pokemon in RunManager.current_run["team"]:
		RunManager.current_run["team"].append(
			pokemon
		)

	RunManager.current_run["alive_count"] = (
		RunManager.current_run["team"].size()
	)

	RunManager.current_run["dead_count"] = (
		RunManager.current_run["graveyard"].size()
	)

	RunManager.save_current_run()

	refresh_team_views()
