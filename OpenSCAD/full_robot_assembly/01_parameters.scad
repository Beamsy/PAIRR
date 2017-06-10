//-- Set Up ---------------------------------//
//-------------------------------------------//
$fn = 50.0;   // default minimum number of facets
$fa = 1.0;    // default minimum facet angle
$fs = 1.0;    // default minimum facet size

//-- Module Parameters ----------------------//
//-------------------------------------------//

// BEARING RACE
    // dimensions for building bearing race
        bearing_radius = 3.0;
        race_cup_radius = 13.5;
        cup_block_width = 9.0;
        cup_block_height = 2.0;

// MOTOR CUT BLOCKS
    // dimensions for cut hole for mounting motors in motor clamps (universal)
        motor_body_cut_block_width = 23.2;
        motor_body_cut_block_length = 12.5;
        top_cut_block_height = 7.25;
        top_cut_block_height_lugs = 2.75;
        top_cut_block_width_lugs = 32.75;
        top_cut_block_small_radius = 2.75;
    // dimensions for cut hole for motor wires
        wire_cut_block_width = 3.5;
        wire_cut_block_length = 5;

// ROUNDED BLOCKS 
    // dimensions for building rounded rectangular blocks (universal)
        corner_radius = 5;
        top_rounded_block_height = 8.6;
        bottom_rounded_block_height = 3.5;
    // dimensions for building rounded rectangular blocks (neck; top and bottom sections)
        neck_top_rounded_block_width = 90;
        neck_top_rounded_block_length = 40;
        neck_bottom_rounded_block_width = neck_top_rounded_block_width;
        neck_bottom_rounded_block_length = neck_top_rounded_block_length;
    // dimensions for building rounded rectangular blocks (shoulder; top and bottom sections)
        shoulder_top_rounded_block_width = 70;
        shoulder_top_rounded_block_length = neck_top_rounded_block_length;
        shoulder_bottom_rounded_block_width = shoulder_top_rounded_block_width;
        shoulder_bottom_rounded_block_length = shoulder_top_rounded_block_length;
    // dimensions for building rounded rectangular blocks (torso sections)
        joint_bolt_hole_bottomedge_offsett = 5.75;
        torso_top_rounded_block_width = neck_top_rounded_block_width;
        torso_top_rounded_block_length = neck_top_rounded_block_length;
        torso_top_rounded_block_height = 85.0;
        torso_join_rounded_block_width =    neck_top_rounded_block_width 
                                            +2*bottom_rounded_block_height;
        torso_join_rounded_block_length =   neck_top_rounded_block_length
                                            +2*bottom_rounded_block_height;
        torso_join_rounded_block_height =   joint_bolt_hole_bottomedge_offsett*2 + 10;
        torso_join_corner_radius = corner_radius + bottom_rounded_block_height;
    // dimensions for building rounded rectangular block (spline hat section)
        spline_hat_rounded_block_width = 60;
        spline_hat_rounded_block_length = neck_top_rounded_block_length;

// SPLINE HAT ASSEMBLY
    // twodof motor holder
        twodof_left_axle_thick_block_height = top_rounded_block_height;
        twodof_left_axle_slim_block_height = bottom_rounded_block_height;
        twodof_thin_material_thickness = 2.0;
        twodof_left_axle_basic_block_width =    top_cut_block_width_lugs
                                                +twodof_thin_material_thickness;
        twodof_left_axle_basic_block_length =   spline_hat_rounded_block_length
                                                -2*corner_radius;
        twodof_left_axle_basic_block_nut_height = 6.25;
        twodof_left_axle_basic_block_nut_holder_width = twodof_left_axle_basic_block_nut_height
                                                        +2*twodof_thin_material_thickness;
        twodof_join_holes_dist_from_center =    motor_body_cut_block_length/4
                                                +twodof_left_axle_basic_block_length/4;
        twodof_right_axle_hole_radius = 4;
        twodof_top_axle_part_basic_block_width = 24+twodof_left_axle_slim_block_height;
        twodof_top_axle_L_bracket_width = 13;
        twodof_top_axle_L_bracket_axle_radius = 3.70;
        twodof_top_axle_L_bracket_axle_height = twodof_left_axle_thick_block_height+0.25;
        twodof_top_axle_L_bracket_axle_block_washer_radius = twodof_top_axle_L_bracket_axle_radius+2.0;
        twodof_top_axle_L_bracket_axle_block_washer_height = 5.0;

// TORSO CUT BLOCKS
    // dimensions for torse cut blocks
        torso_top_cut_corner_radius =   corner_radius
                                        -bottom_rounded_block_height;
        torso_top_cut_rounded_block_width =     neck_bottom_rounded_block_width
                                                -2*bottom_rounded_block_height;
        torso_top_cut_rounded_block_length =    neck_bottom_rounded_block_length
                                                -2*bottom_rounded_block_height;
        torso_join_cut_rounded_block_width =     torso_join_rounded_block_width
                                                -2*bottom_rounded_block_height;
        torso_join_cut_rounded_block_length =    torso_join_rounded_block_length
                                                -2*bottom_rounded_block_height;
        torso_join_cut_corner_radius = corner_radius;
                                                
// BOLT HOLES
    // dimensions for bolt holes and countersinks (universal)
        countersink_hole_radius = 3.0;
        countersink_hole_depth = 3.0;
        bolt_hole_radius = 1.75;
        top_bolt_hole_height = top_rounded_block_height;
        bottom_bolt_hole_height = bottom_rounded_block_height;
        spline_hat_bolt_hole_height = bottom_rounded_block_height;
    // dimensions for neck bolt hole position
        neck_bolt_hole_dist_from_center =   cup_block_width/4 + 
                                            race_cup_radius/2 + 
                                            neck_top_rounded_block_width/4;
    // dimensions for shoulder bolt hole position
        shoulder_bolt_hole_dist_from_center =   cup_block_width/4 + 
                                                race_cup_radius/2 + 
                                                shoulder_top_rounded_block_width/4;
    // dimensions for spline hat bolt hole position
        spline_hat_bolt_hole_dist_from_center = cup_block_width/4 + 
                                                race_cup_radius/2 + 
                                                spline_hat_rounded_block_width/4;

// ARDUINO MOUNT HOLES 
    // dimensions array to subtract mounting holes from top torso section
        arduino_mount_hole_radius = bolt_hole_radius;
        // coordinates to locate mount holes
            x_tl = -19.5; y_tl = +24.25;
            x_tr = +31.5; y_tr = +9.25;
            x_bl = -20.5; y_bl = -24.25;
            x_br = +31.5; y_br = -19.75;
        mount_hole_gap_width = (-1*x_bl)+x_br;
        mount_hole_gap_length = (-1*y_bl)+y_tl;
        mount_hole_dist_from_top = 12.5;
        weight_loss_block_offset = mount_hole_gap_width/2 + x_bl;

// SPLINE HAT
    // dimensions for building spline hat
        spline_hat_height = 3;
        spline_hat_thickness = 0.8;
        spline_screw_hole_radius = 1.0;
        inner_radius = 2.5;
        outer_radius = inner_radius + spline_hat_thickness;
    // dimensions for building individual splines for spline hat
        pi = 3.14159;
        circumference = 2*pi*inner_radius;
        spline_no = 25;
        spline_width = (circumference/spline_no)*1.01;
        spline_height = spline_width/2;

// FACE
    // top mount plate
    twodof_top_plate_mount_holes_dist_from_center = spline_hat_rounded_block_width/2-1;
    twodof_top_plate_mount_holes_dist_from_eachother = twodof_top_axle_part_basic_block_width/3;
    // lED mount plate
    twodof_LED_mount_holes_dist_from_center = 13.1;
    twodof_LED_mount_holes_dist_from_eachother = 22.4;
    // face plate
    twodof_face_plate_rounded_block_width = neck_top_rounded_block_width;
    twodof_face_plate_rounded_block_length = 2*twodof_LED_mount_holes_dist_from_eachother+30;

// TORSO BOTTOM AND MIDDLE SECTION
    // dimensions for torso bottom section
    torso_bottom_rounded_block_height = 90.0;
    // speaker mount dimensions
    speaker_hole_radius = 51.0/2;
    speaker_bolt_holes_dist_from_center = 42.5/2;
    speaker_hole_edge_offset = 4.0;
    // pwm board hole cut dimanesion
    pwm_hole_dist_from_center = 55.0/2;
    pwm_hole_dist_from_eachother = 21.5/2;
    // mini amp mount dimensions
    amp_weight_hole_width = 8.5;
    amp_weight_hole_length = 11.2;
    amp_weight_hole_radius = 2.5;
    amp_mount_hole_radius = 2.8/2;
    amp_mount_hole_dist_from_eachother = 10.5;
    // holes for mounting audio jack socket
    audio_jack_radius = 8.0/2;
    audio_jack_countersink_radius = 12.0/2;
    audio_jack_countersink_depth = 2.0;
    audio_jack_dist_from_center = 6.0;
    // holes for mouting DC power jack
    power_jack_radius = 11.8/2;
    power_jack_dist_from_center = 10.0;
    // dimensions for torso middle section
    torso_middle_rounded_block_height = 2*pwm_hole_dist_from_eachother
                                    +torso_join_rounded_block_height
                                    +15;

// TORSO FEET SECTION
    // torso feet
    toe_width = 8.0;
    toe_length = toe_width*2;
    toe_gap = 1.5;

// UPPER ARM 
    // upper arm top section
    upper_arm_rounded_block_width = 2*race_cup_radius+cup_block_width+25;
    upper_arm_rounded_block_length = 2*race_cup_radius+cup_block_width;
    upper_arm_join_offsett = 12.0;
    // upper arm bottom section
    upper_arm_bolts_dist_from_center =  upper_arm_rounded_block_width/2
                                        -countersink_hole_radius
                                        -2.5;
    elbow_motor_offset = -2.5;

// LOWER ARM 
    // module for building roudned block for lower arm motor mount section
    lower_arm_bolt_offsett = 3.0;
    lower_rounded_block_width = top_cut_block_width_lugs
                                +2*bolt_hole_radius
                                +6*lower_arm_bolt_offsett;
    lower_rounded_block_length =    motor_body_cut_block_length
                                    +2*bottom_rounded_block_height;
    lower_arm_bolt_hole_dist_from_center =  top_cut_block_width_lugs/2
                                            +bolt_hole_radius
                                            +lower_arm_bolt_offsett;
    lower_arm_strut_width = lower_rounded_block_width;

// BASE RAFT
    // dimensions for adding a base raft for printing
        raft_base_height = 0.25;
