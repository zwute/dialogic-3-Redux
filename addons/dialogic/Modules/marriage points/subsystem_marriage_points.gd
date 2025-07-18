extends DialogicSubsystem

var marriage_points: Dictionary = {}
var marriage_thresholds: Dictionary = {}

func clear_game_state(_clear_flag := DialogicGameHandler.ClearFlags.FULL_CLEAR) -> void:
    marriage_points.clear()
    load_marriage_settings()

func load_game_state(_load_flag := LoadFlags.FULL_LOAD) -> void:
    marriage_points = dialogic.current_state_info.get('marriage_points', {})
    load_marriage_settings()

func load_marriage_settings() -> void:
    marriage_thresholds = ProjectSettings.get_setting('dialogic/marriage/thresholds', {})

func get_marriage_points(character_id: String) -> int:
    return marriage_points.get(character_id, 0)

func add_marriage_points(character_id: String, points: int) -> void:
    marriage_points[character_id] = marriage_points.get(character_id, 0) + points
    dialogic.current_state_info['marriage_points'] = marriage_points

func set_marriage_points(character_id: String, points: int) -> void:
    marriage_points[character_id] = points
    dialogic.current_state_info['marriage_points'] = marriage_points

func can_marry(character_id: String) -> bool:
    var threshold = marriage_thresholds.get(character_id, 100)
    return get_marriage_points(character_id) >= threshold

func get_marriage_level(character_id: String) -> String:
    var points = get_marriage_points(character_id)
    if points >= marriage_thresholds.get(character_id, 100):
        return "Marriageable"
    elif points >= 50:
        return "Close"
    elif points >= 25:
        return "Interested"
    else:
        return "Distant"