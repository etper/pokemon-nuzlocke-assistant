extends Control

const EncounterData = preload("res://encounter_data.gd")

@onready var encounter_list = $ScrollContainer/EncounterList

func _ready() -> void:
	setup(RunManager.current_run)

func setup(data: Dictionary) -> void:
	$GameLabel.text = str(data.get("game", "Unknown"))
	$BadgeLabel.text = "Badges: %d" % int(data.get("badges", 0))

	build_encounters(data)

func build_encounters(run_data:Dictionary):

	for child in encounter_list.get_children():
		child.queue_free()

	var routes = EncounterData.get_routes(
		run_data["game"]
	)

	for route_name in routes.keys():

		var route_box = VBoxContainer.new()

		var title = Label.new()
		title.text = route_name

		route_box.add_child(title)

		for pokemon in routes[route_name]:

			var button = CheckBox.new()

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
	route_name:String,
	pokemon:String
):

	if not RunManager.current_run.has("encounters"):
		RunManager.current_run["encounters"] = {}

	RunManager.current_run["encounters"][route_name] = {
		"caught": pokemon
	}

	RunManager.save_current_run()

	get_tree().reload_current_scene()
