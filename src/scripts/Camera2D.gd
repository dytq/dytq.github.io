extends Camera2D

var target_position = self.position

func _process(delta):
	if(target_position != self.position):
		self.position = lerp(target_position,self.position,0.95)
	
