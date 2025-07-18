@tool
extends DialogicIndexer

func _get_subsystems() -> Array:
    return [{'name':'PlayerName', 'script':this_folder.path_join('subsystem_player_name.gd')}]

func _get_settings_pages() -> Array:
    return [this_folder.path_join('settings_player_name.tscn')]