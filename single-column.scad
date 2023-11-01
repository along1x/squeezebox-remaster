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
        inner_square_depth = 2.3;

        // Create the centered square indentation
        translate([0, 0, outer_box_depth - inner_square_depth])
        cube([inner_square_side, inner_square_side, inner_square_depth+2], center=true);

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

union() {
    // tabs that will attach to the mounting board
    difference() {
        cube([110, outer_box_height, outer_box_depth], center=true);
        cube([60.8, outer_box_height+2, outer_box_depth+2], center=true);
        
        translate([-45, 0, 0])
        cylinder(h=outer_box_depth+2, r=4, center=true, $fn = 100);
        
        translate([45, 0, 0])
        cylinder(h=outer_box_depth+2, r=4, center=true, $fn = 100);
    };
    
    translate([-outer_box_width-.72, 0, .47])
    rotate([0, 38, 0])
    cube([.75, outer_box_height, 2], center=true);
    
    translate([-55, 0, -13.5])
    cube([outer_box_depth, outer_box_height, 30], center=true);
    
    
    translate([55, 0, -13.5])
    cube([outer_box_depth, outer_box_height, 30], center=true);

    // draw the keywells
    translate([5, 0, -23.5])
    rotate([0, 13, 0])
    union() {
        // center row
        key_well();
        
        // lower row
        translate([outer_box_width/2+outer_box_depth, 0, outer_box_height-2])
        rotate([0, lower_row_rotation, 0])
        key_well();
        
        // square off the corner
        translate([outer_box_width/2+.3, 0, 0])
        rotate([0, 50, 0])
        cube([2, outer_box_height, 2.4], center=true);
        
        // upper row
        translate([-outer_box_width+outer_box_depth-0.25, 0, (outer_box_width/2) * sin(upper_row_rotation) -.2])
        rotate([0, upper_row_rotation, 0])
        key_well();
    };
}