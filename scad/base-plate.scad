col_width = 19;
width = col_width * 5 + 10; // 5 fingers + some clearances
height = 3;

screw_width = 4.25;
slot_length = 30; // length between the center of the screw in the lowest to the highest position

length = 108 + slot_length + screw_width; // 108 length per column, plus some clearance to customize variance between fingers (slot len)

module groove() {
    union() {
        translate([screw_width/2, screw_width/2, 0])
        cylinder(h=height+2, r=screw_width/2, $fn=100);
        
        translate([0, screw_width/2, 0])
        cube([screw_width, slot_length, height+2]);
        
        translate([screw_width/2, screw_width/2+slot_length, 0])
        cylinder(h=height+2, r=screw_width/2, $fn=100);
    }
}

module col_groove() {
    translate([0, 9, -1])
    groove();
    translate([0, 99, -1])
    groove();
}

module mount_point(total_depth, use_screw) {
    width = 9;
    bolt_width = 3.2;
    nut_width = 6.5;
    nut_depth = 2.25;
    difference() {
        union() {
            translate([-width / 2, 0, 0])
            cube([width / 2, width, total_depth]);
            
            translate([-width/2, width/2, 0])
            cylinder(h=total_depth, r=width/2, $fn=100);
        };
        
        if(!use_screw){
            translate([-width/2, width/2, -1])
            cylinder(h=total_depth+2, r=bolt_width/2, $fn=100);
        }
        else {
            translate([-width/2, width/2, -1])
            cylinder(h=nut_depth+1, r=nut_width/2, $fn=6);
            
            translate([-width/2, width/2, nut_depth-1])
            cylinder(h=total_depth-nut_depth+3, r=bolt_width/2, $fn=100);
        }
    };
}

difference () {
    union() {
        // main body
        cube([width, length, height]);
        
        // mounting point for thumb cluster
        mount_point(height, false);
        
        // hinges for controller cage        
        translate([width-9, 9, height])
        rotate([90, 90, 0])
        mount_point(5, true);
        
        translate([width, length - 9, height])
        rotate([90, 90, 180])
        mount_point(5, true);
        
        // lock points
        translate([16, length - 9, height])
        rotate([90, 90, 180])
        mount_point(5, true);
        
        translate([7, 9, height])
        rotate([90, 90, 0])
        mount_point(5, true);
    }
    
    // index finger / double width
    translate([col_width, 0, 0])
    col_groove();
    
    // middle thru pinky / single width
    translate([col_width*2.5, 0, 0])
    col_groove();
    
    translate([col_width*3.5, 0, 0])
    col_groove();
    
    translate([col_width*4.5, 0, 0])
    col_groove();

    // dig out a center channel that can more easily route wiring
    translate([col_width,70,-2])
    cube([col_width*3.75, 15, height+5]);
    
}