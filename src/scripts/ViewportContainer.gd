extends SubViewportContainer

var target_position : Vector2 = self.position 

var is_display = false

func _process(delta):
	if(target_position != self.position):
		self.position = lerp(target_position,self.position,0.95)
	if(self.is_visible_in_tree()):
		if(is_display == false and target_position.x > position.x-1 and target_position.x < position.x+1):
			self.hide()
			get_parent().remove_viewport_scene()

func set_display(target_position_entry, rect_position_entry):
	self.show()
	self.position = rect_position_entry
	self.target_position = target_position_entry
	is_display = true

func set_undisplay(target_position_entry):
	self.target_position = target_position_entry
	is_display = false
