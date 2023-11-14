col_width = 17;
width = col_width * 5 + 10; // 5 fingers + some clearances
thickness = 3;

// base plate hinges, for reference...

//// hinges for controller cage        
//translate([0, 10.15, height])
//rotate([90, 90, 0])
//mount_point(5, true);
//
//translate([9, 82, height])
//rotate([90, 90, 180])
//mount_point(5, true);
//
//// lock point
//translate([width - 3, 82, height])
//rotate([90, 90, 180])
//mount_point(5, true);

cube([width, 85, 20]);