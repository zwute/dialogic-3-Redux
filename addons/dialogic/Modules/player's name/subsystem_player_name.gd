extends DialogicSubsystem

var player_name: String = ""

func clear_game_state(_clear_flag := DialogicGameHandler.ClearFlags.FULL_CLEAR) -> void:
    player_name = ""

func load_game_state(_load_flag := LoadFlags.FULL_LOAD) -> void:
    player_name = dialogic.current_state_info.get('player_name', '')

func get_player_name() -> String:
    return player_name

func set_player_name(name: String) -> void:
    player_name = name.strip()
    dialogic.current_state_info['player_name'] = player_name

func prompt_player_name(prompt_text: String = "What is your adventurer name?", max_length: int = 32) -> String:
    var input_name = ""
    # This would need to be implemented with a custom dialog or input system
    # For now, return the current name or empty string
    return player_name