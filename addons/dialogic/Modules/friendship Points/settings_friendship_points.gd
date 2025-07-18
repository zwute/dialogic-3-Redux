@tool
extends DialogicSettingsPage

func _refresh() -> void:
    var levels = ProjectSettings.get_setting('dialogic/friendship/levels', {
        "Stranger": 0,
        "Acquaintance": 10,
        "Friend": 25,
        "Good Friend": 50,
        "Best Friend": 75
    })
    
    %StrangerPoints.value = levels.get("Stranger", 0)
    %AcquaintancePoints.value = levels.get("Acquaintance", 10)
    %FriendPoints.value = levels.get("Friend", 25)
    %GoodFriendPoints.value = levels.get("Good Friend", 50)
    %BestFriendPoints.value = levels.get("Best Friend", 75)

func _save_levels() -> void:
    var levels = {
        "Stranger": int(%StrangerPoints.value),
        "Acquaintance": int(%AcquaintancePoints.value),
        "Friend": int(%FriendPoints.value),
        "Good Friend": int(%GoodFriendPoints.value),
        "Best Friend": int(%BestFriendPoints.value)
    }
    ProjectSettings.set_setting('dialogic/friendship/levels', levels)
    ProjectSettings.save()

func _ready() -> void:
    %StrangerPoints.value_changed.connect(_on_value_changed)
    %AcquaintancePoints.value_changed.connect(_on_value_changed)
    %FriendPoints.value_changed.connect(_on_value_changed)
    %GoodFriendPoints.value_changed.connect(_on_value_changed)
    %BestFriendPoints.value_changed.connect(_on_value_changed)

func _on_value_changed(_value: float) -> void:
    _save_levels()