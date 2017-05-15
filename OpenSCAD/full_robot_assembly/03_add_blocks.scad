//-- Import ---------------------------------//
//-------------------------------------------//
include <01_parameters.scad>;
 
//-- Add Block Modules ----------------------//
//-------------------------------------------//

// BEARING RACE
    // module to build bearing race block
    module bearing_race_build_block() {
        translate([0,0,cup_block_height/2 - 0.5])
            rotate_extrude(convexity = 10)
                translate([race_cup_radius,0,0])
                    square([cup_block_width, cup_block_height + 1], center=true);
    }
    // module to subtract race from block and create bearing cup
    module bearing_race_cup() {
        difference () {
            bearing_race_build_block();
            bearing_race_cut_block();
        }
    }

// NECK
    // module to build rounded block for top neck section
    module neck_top_rounded_rectangular_block() {
        translate([0,0,top_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*neck_top_rounded_block_width/2 - x*corner_radius, 
                                    y*neck_top_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = top_rounded_block_height, center = true);
                    }
                }
                cube([  neck_top_rounded_block_width - 2*corner_radius, 
                        neck_top_rounded_block_length, 
                        top_rounded_block_height], center = true);
                cube([  neck_top_rounded_block_width, 
                        neck_top_rounded_block_length - 2*corner_radius, 
                        top_rounded_block_height], center = true);       
            }
    }
    // module to build rounded block for bottom neck section
    module neck_bottom_rounded_rectangular_block() {
        translate([0, 0, bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*neck_bottom_rounded_block_width/2 - x*corner_radius, 
                                    y*neck_bottom_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }
                }
                cube([  neck_bottom_rounded_block_width - 2*corner_radius, 
                        neck_bottom_rounded_block_length,
                        bottom_rounded_block_height], center = true);
                cube([  neck_bottom_rounded_block_width, 
                        neck_bottom_rounded_block_length - 2*corner_radius, 
                        bottom_rounded_block_height], center = true);       
            }
    }

// SHOULDER 
    // module to build rounded block for shoulder top section
    module shoulder_top_rounded_rectangular_block() {
        translate([0,0,top_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*shoulder_top_rounded_block_width/2 - x*corner_radius, 
                                    y*shoulder_top_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = top_rounded_block_height, center = true);
                    }
                }
                cube([  shoulder_top_rounded_block_width - 2*corner_radius, 
                        shoulder_top_rounded_block_length, 
                        top_rounded_block_height], center = true);
                cube([  shoulder_top_rounded_block_width, 
                        shoulder_top_rounded_block_length - 2*corner_radius, 
                        top_rounded_block_height], center = true);       
            }
    }
    // module to build rounded block for shoulder bottom section
    module shoulder_bottom_rounded_rectangular_block() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*shoulder_bottom_rounded_block_width/2 - x*corner_radius, 
                                    y*shoulder_bottom_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }
                }
                cube([  shoulder_bottom_rounded_block_width - 2*corner_radius, 
                        shoulder_bottom_rounded_block_length, 
                        bottom_rounded_block_height], center = true);
                cube([  shoulder_bottom_rounded_block_width, 
                        shoulder_bottom_rounded_block_length - 2*corner_radius, 
                        bottom_rounded_block_height], center = true);       
            }
    }
    
// TORSO TOP SECTION
    // module for building torso top retangular block
    module torso_top_rounded_rectangular_block() {
        translate([0,0,torso_top_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*torso_top_rounded_block_width/2 - x*corner_radius, 
                                    y*torso_top_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius, 
                                        h = torso_top_rounded_block_height, center = true);
                    }
                }
                cube([  torso_top_rounded_block_width - 2*corner_radius,
                        torso_top_rounded_block_length, 
                        torso_top_rounded_block_height], center = true);
                cube([  torso_top_rounded_block_width,
                        torso_top_rounded_block_length - 2*corner_radius, 
                        torso_top_rounded_block_height], center = true);
            }
    }

// TORSO JOIN SECTION
    // module for building torso top retangular block
    module torso_join_rounded_block() {
        translate([0,0,0])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*torso_join_rounded_block_width/2 - x*torso_join_corner_radius, 
                                    y*torso_join_rounded_block_length/2 - y*torso_join_corner_radius,0])
                            cylinder(   r = torso_join_corner_radius, 
                                        h = torso_join_rounded_block_height, center = true);
                    }
                }
                cube([  torso_join_rounded_block_width - 2*torso_join_corner_radius,
                        torso_join_rounded_block_length, 
                        torso_join_rounded_block_height], center = true);
                cube([  torso_join_rounded_block_width,
                        torso_join_rounded_block_length - 2*torso_join_corner_radius, 
                        torso_join_rounded_block_height], center = true);
            }
    }
    
// SPLINE HAT
    // module to build a single spline for the spline hat
    module spline(){
        rotate([90,180,0])
            linear_extrude(height = spline_hat_height+1)
                translate([ -spline_width/2,
                            (-spline_height/2)-spline_hat_thickness*0.9,0])
                    polygon(points =    [[0,0],
                                        [spline_width,0],
                                        [spline_width,spline_hat_thickness*0.9],
                                        [spline_width/2,spline_height+spline_hat_thickness*0.9],
                                        [0,spline_hat_thickness*0.9]
                                        ]);
    }
    // module to build an array of spines
    module spline_array(){
        translate([0,0,spline_hat_height])
        rotate([90,0,0])
            union(){
                for(i=[0:spline_no]){
                    rotate([0,(360/spline_no)*i,0])
                    translate([0,0,inner_radius-spline_height/2])
                        spline();
                }
            }
    }
    // module to build a barrel to contain the spline array
    module spline_barrel(){
        translate([0,0,spline_hat_height/2 - 0.5])
            difference() {
                cylinder(   r = outer_radius,
                            h = spline_hat_height + 1,
                            $fn=50, center = true);
                cylinder(   r = inner_radius,
                            h = spline_hat_height + 2,
                            $fn=50, center = true);
            }
    }
    // module to build rounded block for spline hat section
    module spline_hat_rounded_rectangular_block() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*spline_hat_rounded_block_width/2 - x*corner_radius, 
                                    y*spline_hat_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }
                }
                cube([  spline_hat_rounded_block_width - 2*corner_radius, 
                        spline_hat_rounded_block_length,
                        bottom_rounded_block_height], center = true);
                cube([  spline_hat_rounded_block_width,
                        spline_hat_rounded_block_length - 2*corner_radius, 
                        bottom_rounded_block_height], center = true);       
            }
    }

// SPLINE HAT ASSEMBLY
    // module for 2DOF left axle basic block
    module twodof_left_axle_basic_block(block_height) {
        translate([0,0,block_height/2])
        cube([  twodof_left_axle_basic_block_width,
                twodof_left_axle_basic_block_length,
                block_height], center = true);
    }
    // module for 2DOF top axle basic block
    module twodof_top_axle_basic_block(block_height) {
        translate([0,0,block_height/2])
        cube([  twodof_top_axle_part_basic_block_width,
                twodof_left_axle_basic_block_length,
                block_height], center = true);
    }
    // module for 2DOF top axle L bracket
    module twodof_top_axle_L_bracket() {
        difference() {
            translate([ twodof_top_axle_part_basic_block_width/2
                        +twodof_top_axle_L_bracket_width/2-1,0,
                        twodof_left_axle_thick_block_height/2
                        +twodof_left_axle_slim_block_height/2])
                cube([ twodof_top_axle_L_bracket_width+2,
                        twodof_left_axle_basic_block_length,
                        twodof_left_axle_thick_block_height
                        +twodof_left_axle_slim_block_height], center = true);    
            translate([ twodof_top_axle_part_basic_block_width/2
                        +twodof_top_axle_L_bracket_width/2
                        -twodof_left_axle_slim_block_height,0,
                        twodof_left_axle_thick_block_height/2
                        +twodof_left_axle_slim_block_height+1])
                cube([  twodof_top_axle_L_bracket_width,
                        twodof_left_axle_basic_block_length+2,
                        twodof_left_axle_thick_block_height+2], center = true);
        }
    }
    // module for 2DOF top axle L bracket with join holes
    module twodof_top_axle_L_bracket_with_join_holes() {
        difference() {
            twodof_top_axle_L_bracket();
            rotate([90,0,90])
            translate([ 0,(twodof_left_axle_thick_block_height
                        +twodof_left_axle_slim_block_height
                        +twodof_left_axle_slim_block_height)/2,
                        twodof_top_axle_part_basic_block_width/2
                        +twodof_left_axle_basic_block_length/8])
                top_rounded_bolt_holes(twodof_top_axle_part_basic_block_width/3);
        }
    }
    // module for 2DOF right axle axle 
    module right_axle() {
        translate([0,0, twodof_top_axle_L_bracket_axle_height/2
                        +bottom_rounded_block_height
                        +twodof_top_axle_L_bracket_axle_block_washer_height/2-0])
            union() {
                cylinder(   r = twodof_top_axle_L_bracket_axle_radius,
                            h = twodof_top_axle_L_bracket_axle_height
                                +twodof_top_axle_L_bracket_axle_block_washer_height+0,
                            $fn=50, center = true);
                translate([0,0, -twodof_top_axle_L_bracket_axle_height/2-0.5])
                    cylinder(   r = twodof_top_axle_L_bracket_axle_block_washer_radius,
                                h = twodof_top_axle_L_bracket_axle_block_washer_height + 1,
                                $fn=50, center = true);
            }
    }
    // module for 2DOF right axle cap
    module right_axle_cap() {
        translate([0,0, twodof_top_axle_L_bracket_axle_block_washer_height/2])
            difference() {
                cylinder(   r = twodof_top_axle_L_bracket_axle_block_washer_radius,
                            h = twodof_top_axle_L_bracket_axle_block_washer_height,
                            $fn=50, center = true);
                cylinder(  r = bolt_hole_radius,
                            h = twodof_top_axle_L_bracket_axle_block_washer_radius+1,
                            $fn=50, center = true);
            }
    }
    // module for 2DOF left axle basic block rounded top
    module twodof_basic_block_rounded_top(block_height) {
        difference() {
            union() {
                translate([-twodof_left_axle_basic_block_length/2,0,0])
                    cube([ twodof_left_axle_basic_block_length,
                            twodof_left_axle_basic_block_length,
                            block_height], center = true);
                    scale([0.5,1,1])
                    cylinder(   r = twodof_left_axle_basic_block_length/2,
                                h = block_height, center = true);
            }
            translate([-twodof_left_axle_basic_block_length/2-2,0,0])
                cube([  twodof_left_axle_basic_block_length+2,
                        twodof_left_axle_basic_block_length+2,
                        block_height+2], center = true);
        }
    }
    // module for 2DOF left axle nut holder
    module twodof_basic_block_nut_holder(block_height) {
        difference() {
            translate([ -(twodof_left_axle_basic_block_width/2
                        +twodof_left_axle_basic_block_nut_holder_width/2)
                        +twodof_thin_material_thickness/2,0,
                        block_height/2])
                cube([  twodof_left_axle_basic_block_nut_holder_width,
                        twodof_left_axle_basic_block_length,
                        block_height], center = true);
            translate([ -twodof_left_axle_basic_block_width/2
                        -twodof_left_axle_basic_block_nut_holder_width/2
                        +twodof_thin_material_thickness/2,0,
                        block_height/2])
                cube([  twodof_left_axle_basic_block_nut_height,
                        twodof_left_axle_basic_block_length
                        -2*twodof_thin_material_thickness,
                        block_height+2], center = true);
            translate([ -twodof_left_axle_basic_block_width/2
                        -twodof_left_axle_basic_block_nut_holder_width/2
                        -twodof_thin_material_thickness/2
                        -twodof_thin_material_thickness,0,
                        block_height/2])
            rotate([0,90,0])
                cylinder(   r = bolt_hole_radius,
                            h = twodof_thin_material_thickness+2, center = true);
        }
    }

// FACE
    // module to build front rounded block for face
    module face_front_rounded_rectangular_block() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*twodof_face_plate_rounded_block_width/2 - x*corner_radius, 
                                    y*twodof_face_plate_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }
                }
                cube([  twodof_face_plate_rounded_block_width - 2*corner_radius, 
                        twodof_face_plate_rounded_block_length, 
                        bottom_rounded_block_height], center = true);
                cube([  twodof_face_plate_rounded_block_width, 
                        twodof_face_plate_rounded_block_length - 2*corner_radius, 
                        bottom_rounded_block_height], center = true);       
            }
    }
    // module to face mount bracket
    module face_mount_bracket() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [1]) {
                        translate([ x*twodof_face_plate_rounded_block_width/2 - x*corner_radius, 
                                    y*(twodof_top_plate_mount_holes_dist_from_eachother + corner_radius/2),0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }
                }
                cube([  twodof_face_plate_rounded_block_width, 
                        2*(twodof_top_plate_mount_holes_dist_from_eachother + corner_radius/2), 
                        bottom_rounded_block_height], center = true);
                translate([0,corner_radius/2,0])
                    cube([  twodof_face_plate_rounded_block_width - 2*corner_radius, 
                            2*(twodof_top_plate_mount_holes_dist_from_eachother + corner_radius/2) + corner_radius, 
                            bottom_rounded_block_height], center = true);       
                translate([0,-corner_radius/2-6.25,0])
                    cube([  twodof_face_plate_rounded_block_width, 
                            2*(twodof_top_plate_mount_holes_dist_from_eachother + corner_radius/2)
                            +corner_radius
                            +6.25, 
                            bottom_rounded_block_height], center = true);       
            }
        }

// TORSO BOTTOM AND MIDDLE SECTION
    // module for building torso main retangular block
    module torso_bottom_rounded_rectangular_block() {
        translate([0,0,torso_bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*torso_top_rounded_block_width/2 - x*corner_radius, 
                                    y*torso_top_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius, 
                                        h = torso_bottom_rounded_block_height, center = true);
                    }
                }
                cube([  torso_top_rounded_block_width - 2*corner_radius,
                        torso_top_rounded_block_length, 
                        torso_bottom_rounded_block_height], center = true);
                cube([  torso_top_rounded_block_width,
                        torso_top_rounded_block_length - 2*corner_radius, 
                        torso_bottom_rounded_block_height], center = true);
            }
    }

// TORSO FEET SECTION
    // module for building single foot plate
    module torso_single_foot_plate() {
        rotate([0,0,10])
        scale([0.75,1.0,1.0])
        translate([35,  -(4.5*(toe_width+toe_gap)/2)
                        -(3*(toe_width+toe_gap)-toe_gap)/2,0])
            union(){
                for (x = [-2,-1,0,+1,+2]) {
                    translate([ x*toe_width + x*toe_gap,x*x+x,0])
                        cube([  toe_width, toe_length, 
                                bottom_rounded_block_height], center=true);
                }
                translate([0,4.5*(toe_width+toe_gap)/2,0])
                    cube([  5*(toe_width+toe_gap)-toe_gap,
                            3*(toe_width+toe_gap)-toe_gap,
                            bottom_rounded_block_height], center=true);
            }
    }
    // module for building pair of feet plates
    module torso_pair_of_feet_plates() {
        translate([0,5,bottom_rounded_block_height/2])
        union() {
            mirror([1,0,0])
                torso_single_foot_plate();
            torso_single_foot_plate();
        }
    }

// UPPER ARM 
    // module to build rounded block for upper top section
    module upper_arm_top_rounded_rectangular_block() {
        difference() {
            translate([0,0,top_rounded_block_height/2])
                union() {
                    translate([0,0,1.5*bottom_rounded_block_height])
                        cylinder(   r = upper_arm_rounded_block_length/2,
                                    h = top_rounded_block_height
                                        +3*bottom_rounded_block_height, 
                                        center = true);
                    translate([upper_arm_rounded_block_width/4,0,0])
                        cube([  upper_arm_rounded_block_width/2, 
                                upper_arm_rounded_block_length, 
                                top_rounded_block_height], center = true);    
                }
            translate([0,0,(top_rounded_block_height)/2-1])
                cylinder(   r = race_cup_radius,
                            h = top_rounded_block_height
                                +4*bottom_rounded_block_height+2, center = true);
        }
    }
    // module to build slim rounded block for upper top section
    module upper_arm_top_rounded_rectangular_cap_block() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                translate([0,0,0/2])
                    cylinder(   r = upper_arm_rounded_block_length/2,
                                h = bottom_rounded_block_height, 
                                center = true);
                translate([upper_arm_rounded_block_width/4,0,0])
                    cube([  upper_arm_rounded_block_width/2, 
                            upper_arm_rounded_block_length, 
                            bottom_rounded_block_height], center = true);    
            }
    }
    // module to build rounded block for upper arm bottom section
    module upper_arm_bottom_rounded_rectangular_block() {
        translate([0,0,top_rounded_block_height/2])
            union() {
                for (x = [1]) {
                    for (y = [-1, +1]) {
                        translate([ x*upper_arm_rounded_block_width/2 - x*corner_radius, 
                                    y*upper_arm_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = top_rounded_block_height, center = true);
                    }
                }
                translate([-corner_radius/2,0,0])
                cube([  upper_arm_rounded_block_width - corner_radius, 
                        upper_arm_rounded_block_length, 
                        top_rounded_block_height], center = true);
                cube([  upper_arm_rounded_block_width, 
                        upper_arm_rounded_block_length - 2*corner_radius, 
                        top_rounded_block_height], center = true);       
            }
    }
    // module to build slim rounded block for upper arm bottom section
    module upper_arm_bottom_rounded_rectangular_cap_section() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [1]) {
                    for (y = [-1, +1]) {
                        translate([ x*upper_arm_rounded_block_width/2 - x*corner_radius, 
                                    y*upper_arm_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }
                }
                translate([-corner_radius/2,0,0])
                cube([  upper_arm_rounded_block_width - corner_radius, 
                        upper_arm_rounded_block_length, 
                        bottom_rounded_block_height], center = true);
                cube([  upper_arm_rounded_block_width, 
                        upper_arm_rounded_block_length - 2*corner_radius, 
                        bottom_rounded_block_height], center = true);       
            }
    }

// LOWER ARM 
    // module for building rounded block for lower arm motor mount section
    module lower_arm_rounded_rectangular_block() {
        translate([0,0,top_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [+1]) {
                        translate([ x*lower_rounded_block_width/2 - x*corner_radius, 
                                    y*lower_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = top_rounded_block_height, center = true);
                    }   
                }
                cube([  lower_rounded_block_width - 2*corner_radius, 
                        lower_rounded_block_length, 
                        top_rounded_block_height], center = true);
                translate([0,-corner_radius/2,0])
                    cube([  lower_rounded_block_width, 
                            lower_rounded_block_length - corner_radius, 
                            top_rounded_block_height], center = true);
            }
    }
    // module for building rounded block for lower arm motor clamp piece
    module lower_arm_slim_rounded_rectangular_block() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [+1]) {
                        translate([ x*lower_rounded_block_width/2 - x*corner_radius, 
                                    y*lower_rounded_block_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height, center = true);
                    }   
                }
                cube([  lower_rounded_block_width - 2*corner_radius, 
                        lower_rounded_block_length, 
                        bottom_rounded_block_height], center = true);
                translate([0,-corner_radius/2,0])
                    cube([  lower_rounded_block_width, 
                            lower_rounded_block_length - corner_radius, 
                            bottom_rounded_block_height], center = true);
            }
    }

// HAND
    // module for building fingers
    module hand_fingers () {
        scale([0.7,1.3,0.85])
        translate([0,-24,0])
            union(){
                for (x = [-2,-1,0,+1,+2]) {
                    translate([ x*toe_width + x*toe_gap,x*x+x,0])
                        cube([  toe_width, toe_length, 
                                bottom_rounded_block_height], center=true);
                }
                translate([0,16.5,0])
                    cube([  5*(toe_width+toe_gap)-toe_gap,
                            2*(toe_width+toe_gap)-toe_gap,
                            bottom_rounded_block_height], center=true);
            }
    }

// RAFTS
    // module for building print rafts for rounded rectangular parts
    module rounded_rectangular_block_base_raft(raft_width, raft_length) {
        translate([0,0,raft_base_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate(  [x*raft_width/2 - x*corner_radius, 
                                    y*raft_length/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = raft_base_height, center = true);
                    }
                }
                cube([  raft_width - 2*corner_radius, 
                        raft_length, 
                        raft_base_height], center = true);
                cube([  raft_width, 
                        raft_length - 2*corner_radius, 
                        raft_base_height], center = true);       
            }
    }
