@tool
extends DialogicIndexer

func _get_subsystems() -> Array:
    return [{'name':'FriendshipPoints', 'script':this_folder.path_join('subsystem_friendship_points.gd')}]

func _get_settings_pages() -> Array:
    return [this_folder.path_join('settings_friendship_points.tscn')]