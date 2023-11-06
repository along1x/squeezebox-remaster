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

module mount_point(total_depth, use_screw) {
    width = 9;
    bolt_width = 3;
    nut_width = 6;
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
        
        // cross beam for vertical support
        // not sure if i want this yet!
        translate([width, 0, -(width/3-height)/2])
        cube([height, length, width/3]); 
        
        // mounting point for thumb cluster
        mount_point(height, false);
        
        // hinges for controller cage        
        translate([0, 10.15, height])
        rotate([90, 90, 0])
        mount_point(5, true);
        
        translate([9, 82, height])
        rotate([90, 90, 180])
        mount_point(5, true);
        
        // lock point
        translate([width - 3, 82, height])
        rotate([90, 90, 180])
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
}