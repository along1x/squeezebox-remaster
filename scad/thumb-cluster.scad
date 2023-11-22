// Define the dimensions of the outer box
outer_box_width = 17;
outer_box_height = 17;
outer_box_depth = 3;

// Define the dimensions of the large hole
large_hole_diameter = 3.4;
small_hole_diameter = 2.2;

lower_row_rotation = -80;
upper_row_rotation = 30;

module key_well_offsets() {
    union() {
        // Define the dimensions of the inner square indentation
        inner_square_side = 14.5;
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

screw_width = 3.2;
base_plate_thickness = 3;
mount_thickness = 2;

module mount_point(thickness) {
    width = 9;
    
    // mounting point for thumb cluster
    rotate([0, -90, 0])
    difference() {
        union() {
            translate([-width / 2, 0, 0])
            cube([width / 2, width, thickness]);
            
            translate([-width/2, width/2, 0])
            cylinder(h=thickness, r=width/2, $fn=100);
        };
        
        translate([-width / 2, width / 2, -1])
        cylinder(h=thickness + 2, r=screw_width/ 2, $fn=100);
    };
}

tolerance = 0.05;

rotate([0,180,0])
union() {
    difference() {
        // base polygon, with softened/rounded edges
        linear_extrude(height=outer_box_depth) {
            offset(r=3, $fn=100) {
                polygon([
                    [0, 0],
                    [outer_box_width*3+2, 0],
                    [outer_box_width*3+2, outer_box_height],
                    [outer_box_width*2+1, outer_box_height + 5],
                    [outer_box_width+1, outer_box_height + 11],
                    [0, outer_box_height]
                ]);
            };
        };
        
        // cut out my 3 key wells
        translate([outer_box_width/2, outer_box_width/2, outer_box_depth/2])
        key_well_offsets();    
        
        translate([outer_box_width*1.5+1, outer_box_width/2+5, outer_box_depth/2])
        key_well_offsets();
        
        translate([outer_box_width*2.5+2, outer_box_width/2, outer_box_depth/2])
        key_well_offsets();
    };
    
    // add a mounting point to the base
    translate([20, outer_box_width, 0])
    rotate([0,0,45])
    union() {
        translate([0, 0, 0])
        mount_point(4);
        
        translate([8.1, 0, 0])
        mount_point(4);
    }
};