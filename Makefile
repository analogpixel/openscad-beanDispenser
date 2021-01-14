bin=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD
fn=coffee-bean-disp.scad

define create-part
	$(bin) -o $(@).stl $(fn)
endef

middle:
	$(create-part) -D "_build_middle=true"

base:
	$(create-part) -D "_build_base=true"

container:
	$(create-part) -D "_build_container=true"

open:
	$(bin) $(fn) &

all: middle base container
	
clean:
	rm *.stl
