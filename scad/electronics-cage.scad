/**
NOTES

at height 20:
to fit perfboard with rpi pico, i need another 5mm clearance, plus space for a stand off.
i could gain back ~1.5mm of space by cutting down rpi headers, but doesnt seem worth the effort

since my perfboard cant get the microusb anywhere close to flush with the wall, i need to make the hole wide enough to put the whole microusb connector through. test hole should be 5x10mm
same with trrs jack.  9mm diameter circle

stand offs need to be M2 size.  1.85mm diameter, screw right in to the plastic...going to use m2x4s
1mm from wall, 45.75mm between center horiz, 65.25mm vert
*/

col_width = 19;
width = col_width * 5 + 10; // 5 fingers + some clearances
thickness = 3;

cage_height = 28;

// this bit of code must match what is defined in the base plate exactly...
screw_width = 4.25;
slot_length = 30; // length between the center of the screw in the lowest to the highest position
cage_width = 108 + slot_length + screw_width; // 108 length per column, plus some clearance to customize variance between fingers (slot len)

hinge_width = 4.2;

mount_height = 9.2;
mount_width = 6.25;

pcb_width = 45.75;
pcb_depth = 65.25;

trrs_diameter = 9;
usb_width = 5;
usb_length = 10;

module pcb_mount() {
    height = 3;
    outer_diameter = 4;
    inner_diameter = 1.83; // print a little tight
    
    difference() {
        cylinder(h=height, r=outer_diameter/2, center=true, $fn=100);
        cylinder(h=height+1, r=inner_diameter/2, center=true, $fn=100);        
    };
}

//rotate([0,180,0])
union() {
    difference() {
        union() {
            translate([0,cage_width,0])
            rotate([90,0,0])
            linear_extrude(height=cage_width) {
                offset(r=3, $fn=6) {
                    polygon([
                        [3, 3],
                        [3, cage_height-3],
                        [5, cage_height-3],
                        [5, 3]
                    ]);
                };
            };
            
            translate([3,0,0])
            cube([width-3, cage_width, cage_height]);
        };
        
        translate([thickness,thickness,-thickness])
        cube([width-6, cage_width-6, cage_height]);
        
        // cut outs for the hinges
        translate([-1, thickness, -.1])
        cube([hinge_width, mount_width+.2, mount_height+.2]);
        
        translate([-1, cage_width-thickness-mount_width-.2, -.1])
        cube([hinge_width, mount_width+.2, mount_height+.2]);
        
        // cut outs for the hinge bolts
        translate([4.5,-1,4.5])
        rotate([-90,0,0])
        cylinder(r=1.6, h=thickness+2, $fn=100);
        
        translate([4.5,cage_width-thickness-1,4.5])
        rotate([-90,0,0])
        cylinder(r=1.6, h=thickness+2, $fn=100);
        
        // cut outs for the secure bolts
        translate([width-11.5,-1,4.5])
        rotate([-90,0,0])
        cylinder(r=1.6, h=thickness+2, $fn=100);
        
        translate([width-11.5,cage_width-thickness-1,4.5])
        rotate([-90,0,0])
        cylinder(r=1.6, h=thickness+2, $fn=100);
        
        translate([27, -.1, 11.5])
        cube([usb_length, usb_width, 5]);
        
        translate([-.1, trrs_diameter/2+6, cage_height-(trrs_diameter+4)])
        rotate([0, 90, 0])
        cylinder(r=trrs_diameter/2, h=5, $fn=100);
    };

    translate([2.5+thickness,2+thickness,cage_height-thickness-2])
    pcb_mount();
    translate([2.5+thickness+pcb_width,2+thickness,cage_height-thickness-2])
    pcb_mount();
    translate([2.5+thickness,2+thickness+pcb_depth,cage_height-thickness-2])
    pcb_mount();
    translate([2.5+thickness+pcb_width,2+thickness+pcb_depth,cage_height-thickness-2])
    pcb_mount();
};