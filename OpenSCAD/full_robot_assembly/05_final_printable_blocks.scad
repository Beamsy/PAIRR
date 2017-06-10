//-- Import ---------------------------------//
//-------------------------------------------//
include <01_parameters.scad>;

//-- Final Printable Modules (with rafts) ---//
//-------------------------------------------//

    // PART 01: module to print the torsp top section with print raft
    module printable_torso_top_section() {
        translate([ 0,  torso_top_rounded_block_height/2,
                        torso_top_rounded_block_length/2])
        rotate([90,0,0])
            torso_top_front_plate_with_shoulder_motor();
        rounded_rectangular_block_base_raft(    torso_top_rounded_block_width
                                                -2*corner_radius,
                                                torso_top_rounded_block_height);
    }
    // PART 02: module to print the top clamp for the neck rotational motor with print raft
    module printable_neck_motor_clamp_top_plate_with_bearing_race_cup() {
        neck_motor_clamp_top_plate_with_bearing_race_cup();
        rounded_rectangular_block_base_raft(    neck_top_rounded_block_width,
                                                neck_top_rounded_block_length);
    }
    // PART 03: module to print the top clamp for the shoulder rotatational motor with print raft
    module printable_shoulder_motor_clamp_top_plate_with_bearing_race_cup() {
        shoulder_motor_clamp_top_plate_with_bearing_race_cup();
        rounded_rectangular_block_base_raft(    shoulder_top_rounded_block_width,
                                                shoulder_top_rounded_block_length);
    }
    // PART 04: module to print torso join section
    module printable_torso_join_section_with_holes() {
        translate([0,   torso_join_rounded_block_height/2,
                        torso_join_rounded_block_length/2])
        rotate([90,0,0])
            torso_join_section_with_holes();
        translate([0,0,raft_base_height/2])
            cube([  torso_join_rounded_block_width
                    -2*torso_join_corner_radius,
                    torso_join_rounded_block_height,
                    raft_base_height], center = true);
    }
    // PART 05: module to print spline hat with print raft
    module printable_spline_hat_block_with_bearing_race() {
        spline_hat_block_with_bearing_race();
        rounded_rectangular_block_base_raft(    spline_hat_rounded_block_width,
                                                spline_hat_rounded_block_length);
    }
    // PART 06: module to print twodof left axle motor mount block with print raft
    module printable_twodof_left_axle_final_thick_block_with_join_bolts(){
        rotate([180,0,0])
        translate([0,0,-top_rounded_block_height])
            twodof_left_axle_final_thick_block_with_join_bolts();
        translate([ motor_body_cut_block_width/2
                    -motor_body_cut_block_length/2
                    -twodof_left_axle_basic_block_nut_height-1,0,
                    raft_base_height/2])
            cube([  twodof_left_axle_basic_block_width,
                    twodof_left_axle_basic_block_length,
                    raft_base_height], center = true);
    }
    // PART 07: module to print twodof left axle motor clamp with print raft
    module printable_twodof_left_axle_final_slim_block_with_join_bolts() {
        twodof_left_axle_final_slim_block_with_join_bolts();
        translate([ 0,0,raft_base_height/2])
            cube([  twodof_left_axle_basic_block_width,
                    twodof_left_axle_basic_block_length,
                    raft_base_height], center = true);
    }
    // PART 08: module to print spline hat right axle block with print raft
    module printable_twodof_thick_block_right_axle_block() {
        twodof_thick_block_right_axle_block();
        translate([ motor_body_cut_block_width/2
                    -motor_body_cut_block_length/2
                    -twodof_left_axle_basic_block_nut_height-1,0,
                    raft_base_height/2])
            cube([  twodof_left_axle_basic_block_width,
                    twodof_left_axle_basic_block_length,
                    raft_base_height], center = true);
    }
    // PART 09: module to print top part for left axle with spline hat
    module printable_twodof_left_axle_top_part_with_spline_hat_and_L_bracket() {
        twodof_left_axle_top_part_with_spline_hat_and_L_bracket();
        translate([ twodof_left_axle_slim_block_height,0,
                    raft_base_height/2])
        cube([  twodof_top_axle_part_basic_block_width,
                twodof_left_axle_basic_block_length-2,
                raft_base_height], center = true);
    }
    // PART 10: module to print top part for right axle
    module printable_twodof_left_axle_top_part_with_right_axle_and_L_bracket() {
        twodof_left_axle_top_part_with_right_axle_and_L_bracket();
        translate([ twodof_left_axle_slim_block_height,0,
                    raft_base_height/2])
            cube([  twodof_top_axle_part_basic_block_width,
                    twodof_left_axle_basic_block_length-2,
                    raft_base_height], center = true);

    }
    // PART 11: module to print top part axle cap
    module printable_right_axle_cap() {
        right_axle_cap();
        translate([ 0,0,raft_base_height/2])
            cylinder(   r = twodof_top_axle_L_bracket_axle_block_washer_radius,
                        h = raft_base_height,
                        $fn=50, center = true);
    }
    // PART 12: module to print face mount bracket
    module printable_face_bracket_complete() {
        face_bracket_complete();
        translate([ 0,0,raft_base_height/2])
            rounded_rectangular_block_base_raft(twodof_face_plate_rounded_block_width,
                                                twodof_face_plate_rounded_block_length);
    }
    // PART 13: module to print torso bottom section with print raft
    module printable_torso_bottom_front_plate_with_jacks_and_amp_holes() {
        torso_bottom_front_plate_with_jacks_and_amp_holes();
        translate([ 0,0,raft_base_height/2])
            rounded_rectangular_block_base_raft(torso_top_rounded_block_width
                                                -bottom_rounded_block_height*2,
                                                torso_bottom_rounded_block_height);
    }
    // PART 14: module to print torso middle section with print raft
    module printable_torso_middle_front_plate_with_pwmboard_holes() {
        torso_middle_front_plate_with_pwmboard_holes();
        translate([ 0,0,raft_base_height/2])
            rounded_rectangular_block_base_raft(torso_top_rounded_block_width
                                                -bottom_rounded_block_height*2,
                                                torso_middle_rounded_block_height);
    }
    // PART 15: module to print torso base with feet section with print raft
    module printable_torso_bottom_feet_section_final() {
        torso_bottom_feet_section_final();
    }
    // PART 16: module to print upper arm motor body
    module printable_upper_arm_motor_body() {
        upper_arm_spline_hat_and_motor_block_complete();
        rounded_rectangular_block_base_raft(97.5,upper_arm_rounded_block_length);
    }
    // PART 17: module to print upper arm motor clamp
    module printable_upper_arm_motor_clamp() {
        upper_arm_motor_clamp_block_complete();
        rounded_rectangular_block_base_raft(97.5,upper_arm_rounded_block_length);
    }
    // PART 18: module to print lower arm motor mounting section
    module printable_lower_arm_complete_motor_mount_section() {
        lower_arm_complete_motor_mount_section();
        translate([-lower_arm_strut_width/2-7,0,0])
            rounded_rectangular_block_base_raft(bearing_radius,bearing_radius);
    }
    // PART 19: module to print lower arm motor clamp
    module printable_lower_arm_motor_clamp() {
        lower_arm_motor_clamp();
        translate([ 0,0,raft_base_height/2])
            rounded_rectangular_block_base_raft(lower_rounded_block_width,
                                                lower_rounded_block_length);
    }
    // PART 20: module to print hand with spline hat
    module printable_hand_complete_with_spline_hat() {
        hand_complete_with_spline_hat();
        translate([ 0,0,raft_base_height/2])
            rounded_rectangular_block_base_raft(35,55);
    }
