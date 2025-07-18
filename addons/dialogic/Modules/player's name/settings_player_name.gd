@tool
extends DialogicSettingsPage

func _refresh() -> void:
    %DefaultNameInput.text = ProjectSettings.get_setting('dialogic/player_name/default_name', '')
    %MaxLengthSpinBox.value = ProjectSettings.get_setting('dialogic/player_name/max_length', 32)

func _on_default_name_input_text_changed(new_text: String) -> void:
    ProjectSettings.set_setting('dialogic/player_name/default_name', new_text)
    ProjectSettings.save()

func _on_max_length_spin_box_value_changed(value: float) -> void:
    ProjectSettings.set_setting('dialogic/player_name/max_length', int(value))
    ProjectSettings.save()

func _ready() -> void:
    %DefaultNameInput.text_changed.connect(_on_default_name_input_text_changed)
    %MaxLengthSpinBox.value_changed.connect(_on_max_length_spin_box_value_changed)