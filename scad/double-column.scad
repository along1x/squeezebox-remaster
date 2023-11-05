// Define the dimensions of the outer box
outer_box_width = 30;
outer_box_height = 17;
outer_box_depth = 3;

// Define the dimensions of the large hole
large_hole_diameter = 3.3;
small_hole_diameter = 2.1;

lower_row_rotation = -80;
upper_row_rotation = 30;

module key_well() {
    difference() {
        // Create the outer box
        cube([outer_box_width, outer_box_height, outer_box_depth], center=true);

        // Define the dimensions of the inner square indentation
        inner_square_side = 13.75;
        inner_square_depth = 2.4;

        // Create the centered square indentation
        translate([0, 0, outer_box_depth - inner_square_depth])
        cube([inner_square_side, inner_square_side, inner_square_depth], center=true);

        // create the stem hole
        cylinder(d = large_hole_diameter, h = outer_box_depth + 2, center=true, $fn = 100);
        
        // Create holes on either side of the stem, for the posts
        translate([-5, 0, 0])
        cylinder(d = small_hole_diameter, h = outer_box_depth + 2, center=true, $fn = 100);

        translate([5, 0, 0])
        cylinder(d = small_hole_diameter, h = outer_box_depth + 2, center=true, $fn = 100);

        translate([0, 5, 0])
        cylinder(d = large_hole_diameter, h = outer_box_depth + 2, center=true, $fn = 100);

        translate([5, 3.25, 0])
        cylinder(d = large_hole_diameter, h = outer_box_depth + 2, center=true, $fn = 100);
    }
}

post_height = 30;

module single_column() {
    union() {
        // tabs that will attach to the mounting board
        difference() {
            union() {
                cube([90, outer_box_height, outer_box_depth], center=true);
                
                translate([-45, 0, -13.5])
                cylinder(h=post_height, d=outer_box_height, center=true, $fn = 100);
                
                translate([45, 0, -13.5])
                cylinder(h=post_height, d=outer_box_height, center=true, $fn = 100);
            }
            
            // cut out a hole for the keywell
            cube([54, outer_box_height+2, outer_box_depth+2], center=true);
            
            // clip a little around a gap between the upper row and post
            translate([-19.12, 1, 0])
            rotate([0, 47.3, 0])
            cube([20, 20, 10], center=true);
            
            // clip a little around the joint between the lower key and post
            translate([24.37, 0, 1])
            rotate([0, -63, 0])
            cube([5, 20, 5], center=true);
        };
        
        // draw the keywells
        difference() {
            translate([-.1, 0, -21.62])
            rotate([0, 17, 0])
            difference() {
                union() {
                    // center row
                    key_well();
                    
                    // lower row
                    translate([outer_box_width/2+outer_box_depth+.5, 0, outer_box_height-1.5])
                    rotate([0, lower_row_rotation, 0])
                    key_well();
                    
                    // bottom support
                    translate([outer_box_width/2+1.4, 0, -1])
                    rotate([0, -10-5, 0])
                    cube([3, outer_box_height, 5], center=true);
                    
                    // upper row
                    translate([-outer_box_width+outer_box_depth+6.4, 0, (outer_box_width/2) * sin(upper_row_rotation) - 2])
                    rotate([0, upper_row_rotation, 0])
                    key_well();
                };
                
                // lower row trim
                translate([-outer_box_width+outer_box_depth+1, 0, (outer_box_width/2) * sin(upper_row_rotation) -2.2])
                rotate([0, upper_row_rotation, 0])
                cube([outer_box_width+4, outer_box_height+2, outer_box_depth], center=true);
                
                
                // upper row trim
                translate([0, 0, -outer_box_depth])
                cube([outer_box_width, outer_box_height+2, outer_box_depth], center=true);
                
                // cutout in the bottom support for wire routing...
                translate([outer_box_width/2+1.8, 0, -2.5])
                rotate([0, -10-5, 0])
                cube([3.5, outer_box_height/2, 2.5], center=true);
            };
            
            // make sure all overhangs on top are snipped off
            translate([0,0, 4])
            cube([90, outer_box_height, outer_box_depth+2], center=true);
        }
    };
}


// this corrects the orientation for printing
//rotate([90, 0, 0])
difference() {
    union() {
        single_column();
        
        translate([0, outer_box_height, 0])
        single_column();
        
        // join posts
        translate([-45, outer_box_height/2, -13.5])
        cube([outer_box_height, outer_box_height, post_height], center=true);
        
        translate([45, outer_box_height/2, -13.5])
        cube([outer_box_height, outer_box_height, post_height], center=true);
    };
    
    // cut out holes for M4 heatset inserts
    translate([-45, outer_box_height/2, -13.5-10])
    cylinder(h=12, r=2.75, center=true, $fn = 100);
    
    translate([45, outer_box_height/2, -13.5-10])
    cylinder(h=12, r=2.75, center=true, $fn = 100);
}