length = 160; // 106 length per column, plus some clearance to customize variance between fingers
col_width = 17;
width = col_width * 5 + 10; // 5 fingers + some clearances
height = 3;

screw_width = 3;
slot_length = 25;

cage_length = 80;

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

module mount_point(depth) {
    difference() {
        union() {
            translate([-((screw_width + 2) / 2), 0, 0])
            cube([(screw_width + 2) / 2, screw_width + 2, depth]);
            
            translate([-screw_width/2-1, screw_width/2+1, 0])
            cylinder(h=depth, r=screw_width/2+1, $fn=100);
        };
        
        translate([-screw_width/2-1, screw_width/2+1, -1])
        cylinder(h=depth+2, r=screw_width/2, $fn=100);
    };
}

difference () {
    union() {
        // main body
        cube([width, length, height]);
        
        // cross beam for vertical support
        // not sure if i want this yet!
        translate([width, 0, -(width/3-height)/2])
        cube([height, length, width/3]); 
        
        // mounting point for thumb cluster
        mount_point(height);
        
        // attachment points for controller cage
        // near point
        translate([0, 2, height])
        rotate([90, 90, 0])
        mount_point(2);
        
        translate([0, 9.15, height])
        rotate([90, 90, 0])
        mount_point(5);
        
        // far point
        translate([0, 84, height])
        rotate([90, 90, 0])
        mount_point(5);
        
        translate([0, 89.15, height])
        rotate([90, 90, 0])
        mount_point(2);
        
        // lock point
        translate([width - screw_width-2, 84, height])
        rotate([90, 90, 0])
        mount_point(5);
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
}