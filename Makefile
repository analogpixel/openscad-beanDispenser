bin=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
fn=coffee-bean-disp.scad

define create-part
	$(bin) -o $(@).stl $(fn)
endef

middle:
	$(create-part) -D "_build_middle=true"

open:
	$(bin) $(fn) &

all: middle
	
clean:
	rm *.stl
