@tool
extends DialogicSettingsPage

func _refresh() -> void:
    var categories = ProjectSettings.get_setting('dialogic/relationship/categories', {
        "trust": {"min": -100, "max": 100},
        "romance": {"min": 0, "max": 100},
        "respect": {"min": -50, "max": 100}
    })
    
    %TrustMin.value = categories.get("trust", {}).get("min", -100)
    %TrustMax.value = categories.get("trust", {}).get("max", 100)
    %RomanceMin.value = categories.get("romance", {}).get("min", 0)
    %RomanceMax.value = categories.get("romance", {}).get("max", 100)
    %RespectMin.value = categories.get("respect", {}).get("min", -50)
    %RespectMax.value = categories.get("respect", {}).get("max", 100)

func _save_categories() -> void:
    var categories = {
        "trust": {"min": int(%TrustMin.value), "max": int(%TrustMax.value)},
        "romance": {"min": int(%RomanceMin.value), "max": int(%RomanceMax.value)},
        "respect": {"min": int(%RespectMin.value), "max": int(%RespectMax.value)}
    }
    ProjectSettings.set_setting('dialogic/relationship/categories', categories)
    ProjectSettings.save()

func _ready() -> void:
    %TrustMin.value_changed.connect(_on_value_changed)
    %TrustMax.value_changed.connect(_on_value_changed)
    %RomanceMin.value_changed.connect(_on_value_changed)
    %RomanceMax.value_changed.connect(_on_value_changed)
    %RespectMin.value_changed.connect(_on_value_changed)
    %RespectMax.value_changed.connect(_on_value_changed)

func _on_value_changed(_value: float) -> void:
    _save_categories()