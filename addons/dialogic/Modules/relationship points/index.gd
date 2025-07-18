@tool
extends DialogicIndexer

func _get_subsystems() -> Array:
    return [{'name':'RelationshipPoints', 'script':this_folder.path_join('subsystem_relationship_points.gd')}]

func _get_settings_pages() -> Array:
    return [this_folder.path_join('settings_relationship_points.tscn')]