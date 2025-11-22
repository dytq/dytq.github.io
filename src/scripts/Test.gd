extends Control

signal return_to_menu

func _ready():
	pass

func _process(delta):
	if(get_window().size.x < 600):
		$ScrollContainer/GridContainer/GridContainer.columns = 1
	else:
		$ScrollContainer/GridContainer/GridContainer.columns = 2


func _on_Button_pressed():
	emit_signal("return_to_menu")
