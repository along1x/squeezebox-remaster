col_width = 19;
width = col_width * 5 + 10; // 5 fingers + some clearances
thickness = 3;

cage_height = 20;

// this bit of code must match what is defined in the base plate exactly...
screw_width = 4.25;
slot_length = 30; // length between the center of the screw in the lowest to the highest position
cage_width = 108 + slot_length + screw_width; // 108 length per column, plus some clearance to customize variance between fingers (slot len)

hinge_width = 4.2;

mount_height = 9.2;
mount_width = 6.25;

rotate([0,180,0])
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
};