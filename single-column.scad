// Define the dimensions of the outer box
outer_box_width = 30;
outer_box_height = 17;
outer_box_depth = 4;

// Define the dimensions of the large hole
large_hole_diameter = 3.5;
small_hole_diameter = 2;

module main_model() {
    difference() {
        // Create the outer box
        cube([outer_box_width, outer_box_height, outer_box_depth], center=true);

        // Define the dimensions of the inner square indentation
        inner_square_width = 13.45;
        inner_square_height = 13.45;
        inner_square_depth = 2;

        // Create the centered square indentation
        translate([0, 0, outer_box_depth - inner_square_depth])
        cube([inner_square_width, inner_square_height, inner_square_depth+2], center=true);

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
    main_model();
    
    translate([outer_box_width/2+outer_box_depth, 0, outer_box_height-2])
    rotate([0, -80, 0])
    main_model();
    
}
