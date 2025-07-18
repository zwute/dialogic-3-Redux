@tool
extends DialogicSettingsPage

func _refresh() -> void:
    %DefaultThresholdSpinBox.value = ProjectSettings.get_setting('dialogic/marriage/default_threshold', 100)
    _refresh_threshold_list()

func _refresh_threshold_list() -> void:
    for child in %ThresholdsList.get_children():
        child.queue_free()
    
    var thresholds = ProjectSettings.get_setting('dialogic/marriage/thresholds', {})
    for character_id in thresholds:
        _add_threshold_row(character_id, thresholds[character_id])

func _add_threshold_row(character_id: String, threshold: int) -> void:
    var row = HBoxContainer.new()
    %ThresholdsList.add_child(row)
    
    var label = Label.new()
    label.text = character_id + ":"
    label.custom_minimum_size = Vector2(150, 0)
    row.add_child(label)
    
    var spinbox = SpinBox.new()
    spinbox.max_value = 1000
    spinbox.value = threshold
    spinbox.value_changed.connect(_on_threshold_changed.bind(character_id))
    row.add_child(spinbox)
    
    var remove_btn = Button.new()
    remove_btn.text = "Remove"
    remove_btn.pressed.connect(_remove_threshold.bind(character_id))
    row.add_child(remove_btn)

func _on_threshold_changed(character_id: String, value: float) -> void:
    var thresholds = ProjectSettings.get_setting('dialogic/marriage/thresholds', {})
    thresholds[character_id] = int(value)
    ProjectSettings.set_setting('dialogic/marriage/thresholds', thresholds)
    ProjectSettings.save()

func _remove_threshold(character_id: String) -> void:
    var thresholds = ProjectSettings.get_setting('dialogic/marriage/thresholds', {})
    thresholds.erase(character_id)
    ProjectSettings.set_setting('dialogic/marriage/thresholds', thresholds)
    ProjectSettings.save()
    _refresh_threshold_list()

func _on_add_button_pressed() -> void:
    var character_id = %CharacterInput.text.strip_edges()
    if character_id.is_empty():
        return
    
    var threshold = int(%ThresholdInput.value)
    var thresholds = ProjectSettings.get_setting('dialogic/marriage/thresholds', {})
    thresholds[character_id] = threshold
    ProjectSettings.set_setting('dialogic/marriage/thresholds', thresholds)
    ProjectSettings.save()
    
    %CharacterInput.text = ""
    _refresh_threshold_list()

func _on_default_threshold_changed(value: float) -> void:
    ProjectSettings.set_setting('dialogic/marriage/default_threshold', int(value))
    ProjectSettings.save()

func _ready() -> void:
    %AddButton.pressed.connect(_on_add_button_pressed)
    %DefaultThresholdSpinBox.value_changed.connect(_on_default_threshold_changed)