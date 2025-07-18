extends DialogicSubsystem

var friendship_points: Dictionary = {}
var friendship_levels: Dictionary = {}

func clear_game_state(_clear_flag := DialogicGameHandler.ClearFlags.FULL_CLEAR) -> void:
    friendship_points.clear()
    load_friendship_settings()

func load_game_state(_load_flag := LoadFlags.FULL_LOAD) -> void:
    friendship_points = dialogic.current_state_info.get('friendship_points', {})
    load_friendship_settings()

func load_friendship_settings() -> void:
    friendship_levels = ProjectSettings.get_setting('dialogic/friendship/levels', {
        "Stranger": 0,
        "Acquaintance": 10,
        "Friend": 25,
        "Good Friend": 50,
        "Best Friend": 75
    })

func get_friendship_points(character_id: String) -> int:
    return friendship_points.get(character_id, 0)

func add_friendship_points(character_id: String, points: int) -> void:
    friendship_points[character_id] = friendship_points.get(character_id, 0) + points
    dialogic.current_state_info['friendship_points'] = friendship_points

func set_friendship_points(character_id: String, points: int) -> void:
    friendship_points[character_id] = points
    dialogic.current_state_info['friendship_points'] = friendship_points

func get_friendship_level(character_id: String) -> String:
    var points = get_friendship_points(character_id)
    var current_level = "Stranger"
    
    for level in friendship_levels:
        if points >= friendship_levels[level]:
            current_level = level
    
    return current_level