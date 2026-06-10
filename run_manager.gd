extends Node

var current_run: Dictionary = {}

const SAVE_DIR := "user://runs/"

func save_current_run():

	var id = current_run["id"]

	var path = SAVE_DIR + id + ".json"

	var file = FileAccess.open(
		path,
		FileAccess.WRITE
	)

	file.store_string(
		JSON.stringify(current_run)
	)
