extends RefCounted

static func get_routes(game:String) -> Dictionary:
	match game:
		"Emerald":
			return {
				"Route 101": [
					"Poochyena",
					"Zigzagoon",
					"Wurmple"
				],

				"Route 102": [
					"Ralts",
					"Lotad",
					"Poochyena",
					"Seedot"
				],

				"Petalburg Woods": [
					"Shroomish",
					"Taillow",
					"Wurmple"
				]
			}

	return {}
