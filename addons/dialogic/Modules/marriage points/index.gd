@tool
extends DialogicIndexer

func _get_subsystems() -> Array:
    return [{'name':'MarriagePoints', 'script':this_folder.path_join('subsystem_marriage_points.gd')}]

func _get_settings_pages() -> Array:
    return [this_folder.path_join('settings_marriage_points.tscn')]