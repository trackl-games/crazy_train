extends Spatial


var dx = 0
var dy = 0
var dz = 0
var xl = -5
var xr = 5
var yl = -5
var yr = 5
var zl = -5
var zr = 5

func init(dx, dy, dz, xl, xr, yl, yr, zl, zr):
	self.dx = dx
	self.dy = dy
	self.dz = dz
	self.xl = xl
	self.xr = xr
	self.yl = yl
	self.yr = yr
	self.zl = zl
	self.zr = zr

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var current = get_global_transform().origin

#	Global.set_location(
#		self,
#		Global.mod_window(current.x + dx*delta, xl, xr),
#		Global.mod_window(current.y + dy*delta, yl, yr),
#		Global.mod_window(current.z + dz*delta, zl, zr)
#	)
	if current.x  + dx*delta < xl and dx < 0:
		current.x = xr
	if current.x  + dx*delta > xr and dx > 0:
		current.x = xl
	Global.set_location(
		self,
		current.x + dx*delta,
		current.y ,
		current.z
	)
	#rotate_object_local(Vector3(0,1,0), delta)
