extends DialogicSubsystem

var relationship_points: Dictionary = {}
var relationship_categories: Dictionary = {}

func clear_game_state(_clear_flag := DialogicGameHandler.ClearFlags.FULL_CLEAR) -> void:
    relationship_points.clear()
    load_relationship_settings()

func load_game_state(_load_flag := LoadFlags.FULL_LOAD) -> void:
    relationship_points = dialogic.current_state_info.get('relationship_points', {})
    load_relationship_settings()

func load_relationship_settings() -> void:
    relationship_categories = ProjectSettings.get_setting('dialogic/relationship/categories', {
        "trust": {"min": -100, "max": 100},
        "romance": {"min": 0, "max": 100},
        "respect": {"min": -50, "max": 100}
    })

func get_relationship_points(character_id: String, category: String = "general") -> int:
    if not relationship_points.has(character_id):
        relationship_points[character_id] = {}
    return relationship_points[character_id].get(category, 0)

func add_relationship_points(character_id: String, category: String, points: int) -> void:
    if not relationship_points.has(character_id):
        relationship_points[character_id] = {}
    
    var current = relationship_points[character_id].get(category, 0)
    var new_value = current + points
    
    # Apply limits if category exists in settings
    if relationship_categories.has(category):
        var limits = relationship_categories[category]
        new_value = clamp(new_value, limits.get("min", -999), limits.get("max", 999))
    
    relationship_points[character_id][category] = new_value
    dialogic.current_state_info['relationship_points'] = relationship_points

func set_relationship_points(character_id: String, category: String, points: int) -> void:
    if not relationship_points.has(character_id):
        relationship_points[character_id] = {}
    
    relationship_points[character_id][category] = points
    dialogic.current_state_info['relationship_points'] = relationship_points

func get_relationship_status(character_id: String, category: String) -> String:
    var points = get_relationship_points(character_id, category)
    
    if points >= 75:
        return "Excellent"
    elif points >= 50:
        return "Good"
    elif points >= 25:
        return "Neutral"
    elif points >= 0:
        return "Poor"
    else:
        return "Hostile"