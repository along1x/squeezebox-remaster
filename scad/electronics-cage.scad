col_width = 17;
width = col_width * 5 + 10; // 5 fingers + some clearances
thickness = 3;

cage_height = 15;
cage_width = 135;

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


mount_height = 9;
mount_width = 5;

difference() {
    cube([width, cage_width, cage_height]);
    
    translate([thickness,thickness,-thickness])
    cube([width-6, cage_width-6, cage_height]);
    
    translate([-1, thickness, -.1])
    cube([4.1, mount_width+.2, mount_height+.2]);
    
    translate([-1, cage_width-thickness-mount_width, -.1])
    cube([4.1, mount_width+.2, mount_height+.2]);
};