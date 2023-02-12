extends Control

signal return_to_menu

func _ready():
	pass

func _process(delta):
	if(OS.window_size.x < 600):
		$ScrollContainer/GridContainer/GridContainer.columns = 1
	else:
		$ScrollContainer/GridContainer/GridContainer.columns = 2


func _on_Button_pressed():
	emit_signal("return_to_menu")


func _on_ButtonRSA_pressed():
	OS.shell_open("https://github.com/RSA-DataSafe")


func _on_ButtonDES1_pressed():
	OS.shell_open("https://github.com/dytq/DataEncryptionStandard")


func _on_ButtonDES2_pressed():
	OS.shell_open("https://gitlab.com/dytq/dns-attaque")


func _on_ButtonAES_pressed():
	OS.shell_open("https://github.com/dytq/AeS")
