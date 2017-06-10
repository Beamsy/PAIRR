//-- Import ---------------------------------//
//-------------------------------------------//
include <01_parameters.scad>;

//-- Compound Modules -----------------------//
//-------------------------------------------//

// NECK BLOCK
    // module to build neck top motor clamp
    module neck_motor_clamp_top_plate() {
        difference() {
            neck_top_rounded_rectangular_block();
            motor_body_top_cut_block_combined();
            top_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            top_rounded_bolt_holes_countersink(neck_bolt_hole_dist_from_center);
        }
    }
    // module to add bearing race to neck top motor clamp
    module neck_motor_clamp_top_plate_with_bearing_race_cup() {
        union() {
            neck_motor_clamp_top_plate();
            translate([0,0,top_rounded_block_height])
                bearing_race_cup();
        }
    }
    //module to create a clamp for the neck bottom
    module neck_motor_clamp_bottom_plate() {
        difference() {
            neck_bottom_rounded_rectangular_block();
            motor_body_bottom_cut_block_combined();
            bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
        }
    }

// SHOULDER BLOCK
    // module to build shoulder top motor clamp
    module shoulder_motor_clamp_top_plate() {
        difference() {
            shoulder_top_rounded_rectangular_block();
            motor_body_top_cut_block_combined();
            top_rounded_bolt_holes(shoulder_bolt_hole_dist_from_center);
            top_rounded_bolt_holes_countersink(shoulder_bolt_hole_dist_from_center);
        }
    }
    // module to add bearing race to shoulder top motor clamp
    module shoulder_motor_clamp_top_plate_with_bearing_race_cup() {
        union() {
            shoulder_motor_clamp_top_plate();
            translate([0,0,top_rounded_block_height])
                bearing_race_cup();
        }
    }
    //module to create a clamp for the shoulder bottom
    module shoulder_motor_clamp_bottom_plate() {
        difference() {
            shoulder_bottom_rounded_rectangular_block();
            motor_body_bottom_cut_block_combined();
            bottom_rounded_bolt_holes(shoulder_bolt_hole_dist_from_center);
        }
    }

// TORSO TOP SECTION
    // module to build torso front plate
    module torso_top_front_plate() {
        difference() {
            union() {
                difference() {
                    torso_top_rounded_rectangular_block();
                    torso_top_cut_block();
                }
                translate([0,0,torso_top_rounded_block_height - bottom_rounded_block_height]) 
                    neck_motor_clamp_bottom_plate();
            }
            torso_top_block_remove_back();
        }
    }
    // module to subtract holes and weight loss block from from torso front plate
    module torso_top_front_plate_with_mount_holes() {
        difference () {
            torso_top_front_plate();
            translate([ weight_loss_block_offset, 
                        -torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        torso_top_rounded_block_height
                        -mount_hole_gap_length/2 
                        -mount_hole_dist_from_top])
            rotate([90,0,0])
                torso_top_block_reduce_front_weight();
            translate([ 0, -torso_top_rounded_block_length/2
                        + bottom_rounded_block_height,
                        torso_top_rounded_block_height
                        -mount_hole_gap_length/2 
                        -mount_hole_dist_from_top])
            rotate([90,0,0])
                arduino_mount_holes();
        }
    }
    // module to subtract bolt holes for joinging torso sections
    module torso_top_front_plate_with_joint_bolt_holes () {
        difference() {
            torso_top_front_plate_with_mount_holes();
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,0,
                        joint_bolt_hole_bottomedge_offsett-bolt_hole_radius])
            side_rounded_bolt_holes(torso_top_rounded_block_length
                                    +bottom_rounded_block_height);

        }
    }
    // module to subtract shoulder motor mount and bolt holes torso sections
    module torso_top_front_plate_with_shoulder_motor () {
        difference() {
            torso_top_front_plate_with_joint_bolt_holes();
            translate([ torso_top_rounded_block_width/2
                        -bottom_rounded_block_height,0,
                        torso_top_rounded_block_height
                        -shoulder_bottom_rounded_block_width/2])
            rotate([0,90,0])
                motor_body_bottom_cut_block_combined();
            translate([ torso_top_rounded_block_width/2
                        -bottom_rounded_block_height,0,
                        torso_top_rounded_block_height
                        -shoulder_bottom_rounded_block_width/2])
            rotate([0,90,0])
                bottom_rounded_bolt_holes(shoulder_bolt_hole_dist_from_center);
        }
    }

// TORSO JOIN SECTION
    // module for building final torso join section
    module torso_join_section_compound() {
        difference() {
            torso_join_rounded_block();
            torso_join_cut_block();
            torso_join_block_remove_back();
        }
    }
    // module for subtracting join holes from final torso join section
    module torso_join_section_with_holes() {
        translate([0,0,torso_join_rounded_block_height/2])
        difference() {
            torso_join_section_compound();
            // top layer of holes
            translate([ 0,-torso_join_rounded_block_length/2
                        +bottom_rounded_block_height,
                        joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,0,
                        joint_bolt_hole_bottomedge_offsett
                        -bolt_hole_radius])
            side_rounded_bolt_holes(torso_top_rounded_block_length
                                    +2*bottom_rounded_block_height);
            // bottom layer of holes
            translate([ 0,-torso_join_rounded_block_length/2
                        +bottom_rounded_block_height,
                        -joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,0,
                        -joint_bolt_hole_bottomedge_offsett
                        -bolt_hole_radius])
            side_rounded_bolt_holes(torso_top_rounded_block_length
                                    +2*bottom_rounded_block_height);
        }
    }
    
// SPLINE HAT
    // module to combine array and barrel to build spline hat
    module spline_hat() {
        translate([0,0,bottom_rounded_block_height])
        union() {
            spline_barrel();
            spline_array();
        }
    }
// module to combine spline hat and rounded base
    module spline_hat_and_base_combined() {
        difference() {
            union() {
                spline_hat();
                spline_hat_rounded_rectangular_block();
            }
            spline_hat_bolt_holes(spline_hat_bolt_hole_dist_from_center);
            spline_screw_hole();
        }
    }
    // module to add bearing race to spline hat
    module spline_hat_block_with_bearing_race() {
        union() {
            spline_hat_and_base_combined();
            translate([0,0,bottom_rounded_block_height])
                bearing_race_cup();
        }
    }

// SPLINE HAT ASSEMBLY
    // module for 2DOF left axle basic block and rounded top combined
    module twodof_basic_block_rounded_top_combined(block_height) {
        union() {
            difference() {
                twodof_left_axle_basic_block(block_height);
                translate([ twodof_left_axle_basic_block_width/8
                            +twodof_left_axle_basic_block_width/2
                            -twodof_left_axle_basic_block_length/6
                            ,0,
                            block_height/2])
                    cube([ twodof_left_axle_basic_block_width/4+1,
                            twodof_left_axle_basic_block_length+2,
                            block_height+2], center = true);
            }
            translate([ twodof_left_axle_basic_block_width/2
                        -twodof_left_axle_basic_block_length/6,0,
                        block_height/2])
                twodof_basic_block_rounded_top(block_height);
        }
    }
    // module for 2DOF top axle basic block and rounded top combined
    module twodof_top_axle_basic_block_rounded_top_combined(block_height) {
        union() {
            difference() {
                twodof_top_axle_basic_block(block_height);
                translate([ twodof_top_axle_part_basic_block_width/8
                            +twodof_top_axle_part_basic_block_width/2
                            -twodof_left_axle_basic_block_length/6
                            ,0,
                            block_height/2])
                    cube([ twodof_top_axle_part_basic_block_width/4+1,
                            twodof_left_axle_basic_block_length+2,
                            block_height+2], center = true);
            }
            translate([ twodof_top_axle_part_basic_block_width/2
                        -twodof_left_axle_basic_block_length/6,0,
                        block_height/2])
                twodof_basic_block_rounded_top(block_height);
        }
    }
    // module for 2DOF left axle thick block and rounded top
    module twodof_thick_block_with_rounded_top() {
        twodof_basic_block_rounded_top_combined(twodof_left_axle_thick_block_height);
    }
    // module for 2DOF left axle slim block and rounded top
    module twodof_slim_block_with_rounded_top() {
        twodof_basic_block_rounded_top_combined(twodof_left_axle_slim_block_height);
    }
    // module for 2DOF left axle with nut holder and motor mount hole
    module twodof_left_axle_with_nut_holder_and_motor() {
        union() {
            difference() {
                twodof_thick_block_with_rounded_top();
                translate([ -motor_body_cut_block_width/2 
                            +motor_body_cut_block_length/2,0,0])
                    motor_body_top_cut_block_combined();
            }
            twodof_basic_block_nut_holder(twodof_left_axle_thick_block_height);
        }
    }
    // module for 2DOF left axle motor clamp
    module twodof_left_axle_motor_clamp() {
        union() {
            difference() {
                twodof_slim_block_with_rounded_top();
                translate([ -motor_body_cut_block_width/2 
                            +motor_body_cut_block_length/2,0,0])
                    motor_body_bottom_cut_block_combined();
            }
            translate([ -twodof_left_axle_basic_block_width/2
                        -twodof_left_axle_basic_block_nut_holder_width/2
                        +1,0,
                        twodof_left_axle_slim_block_height/2])
                cube([  twodof_left_axle_basic_block_nut_holder_width,
                        twodof_left_axle_basic_block_length,
                        twodof_left_axle_slim_block_height],
                        center = true);
        }
    }
    // module for 2DOF left axle top part with spline hat
    module twodof_left_axle_top_part_with_spline_hat() {
        union() {
            rotate([0,0,180])
                twodof_top_axle_basic_block_rounded_top_combined(twodof_left_axle_slim_block_height);
                translate([ -motor_body_cut_block_width/2 
                            +motor_body_cut_block_length/2
                            -twodof_left_axle_slim_block_height/2,0,0])
                    spline_hat();
        }
    }
    // module for 2DOF right axle top part with axle
    module twodof_right_axle_top_part_with_axle() {
        difference() {
            union() {
                rotate([0,0,180])
                    twodof_top_axle_basic_block_rounded_top_combined(twodof_left_axle_slim_block_height);
                translate([ -motor_body_cut_block_width/2 
                            +motor_body_cut_block_length/2
                            -twodof_left_axle_slim_block_height/2,0,0])
                    right_axle();
            }
            translate([ -motor_body_cut_block_width/2 
                        +motor_body_cut_block_length/2
                        -twodof_left_axle_slim_block_height/2,0,
                        (twodof_top_axle_L_bracket_axle_height
                        +bottom_rounded_block_height
                        +twodof_top_axle_L_bracket_axle_block_washer_height)/2])
                cylinder(   r = bolt_hole_radius,
                            h = twodof_top_axle_L_bracket_axle_height
                            +bottom_rounded_block_height
                            +twodof_top_axle_L_bracket_axle_block_washer_height+2,
                            $fn=50, center = true);
            translate([ -motor_body_cut_block_width/2 
                        +motor_body_cut_block_length/2
                        -twodof_left_axle_slim_block_height/2,
                        0,countersink_hole_depth/2-0.5])
                cylinder(   r = countersink_hole_radius,
                            h = countersink_hole_depth+1,
                            $fn=50, center = true);
        }
    }
    // module for 2DOF left axle top part with spline hat and L brakcet
    module twodof_left_axle_top_part_with_spline_hat_and_L_bracket() {
        union() {
            twodof_top_axle_L_bracket_with_join_holes();
            difference() {
                twodof_left_axle_top_part_with_spline_hat();
                translate([ -motor_body_cut_block_width/2 
                            +motor_body_cut_block_length/2
                            -twodof_left_axle_slim_block_height/2,0,0])
                    spline_screw_hole();
            }
        }
    }
    // module for 2DOF left axle top part with right axle and L brakcet
    module twodof_left_axle_top_part_with_right_axle_and_L_bracket() {
        union() {
            twodof_top_axle_L_bracket_with_join_holes();
            twodof_right_axle_top_part_with_axle();
        }
    }
    // module for 2DOF left axle final thick block with join bolt holes added
    module twodof_left_axle_final_thick_block_with_join_bolts() {
        translate([ motor_body_cut_block_width/2
                    -motor_body_cut_block_length/2,0,0])
            difference() {
                twodof_left_axle_with_nut_holder_and_motor();
                twodof_join_holes(twodof_join_holes_dist_from_center);
            }
        }
    // module for 2DOF left axle final slim block with join bolt holes added
    module twodof_left_axle_final_slim_block_with_join_bolts() {
        translate([ motor_body_cut_block_width/2
                    -motor_body_cut_block_length/2,0,0])
            difference() {
                twodof_left_axle_motor_clamp();
                twodof_join_holes(twodof_join_holes_dist_from_center);
            }
        }
    // module for 2DOF right axle thick block
    module twodof_thick_block_right_axle_block() {
        translate([ motor_body_cut_block_width/2
                    -motor_body_cut_block_length/2,0,0])
            union() {
                difference() {
                    twodof_thick_block_with_rounded_top();
                    axle_cylinder_cut_right_axle_block();
                }
                twodof_basic_block_nut_holder(twodof_left_axle_thick_block_height);
            }
        }

// FACE
    // module to build rounded face plate with mount holes
    module face_front_rounded_rectangular_block_with_mount_holes() {
        difference() {
            face_front_rounded_rectangular_block();
        translate([ -twodof_LED_mount_holes_dist_from_eachother,
                    twodof_face_plate_rounded_block_length/2
                    -twodof_LED_mount_holes_dist_from_eachother-10,0])
        cut_bolt_holes_from_top_plate_mount(twodof_LED_mount_holes_dist_from_center,
                                            twodof_LED_mount_holes_dist_from_eachother);
        translate([ twodof_LED_mount_holes_dist_from_eachother,
                    twodof_face_plate_rounded_block_length/2
                    -twodof_LED_mount_holes_dist_from_eachother-10,0])
        cut_bolt_holes_from_top_plate_mount(twodof_LED_mount_holes_dist_from_center,
                                            twodof_LED_mount_holes_dist_from_eachother);
        }
    }
    // module to remove holes from face mount bracket
    module face_mount_bracket_with_holes() {
        difference() {
            face_mount_bracket();
            translate([0,corner_radius+bolt_hole_radius+0.8-5.5,0])
            cut_bolt_holes_from_top_plate_mount(twodof_top_plate_mount_holes_dist_from_center,
                                                twodof_top_plate_mount_holes_dist_from_eachother);
        }
    }
    // module to combine the mount bracket with the face plate and remove weight saving holes
    module face_bracket_complete() {
        difference() {  
            union() {
                translate([ 0,-twodof_face_plate_rounded_block_length/2
                            +bottom_rounded_block_height
                            +2*corner_radius+1.0
                            +25.0,
                            2*twodof_top_plate_mount_holes_dist_from_eachother
                            +bottom_rounded_block_height
                            +6.25])
                rotate([90,0,0])
                    face_mount_bracket_with_holes();
                face_front_rounded_rectangular_block_with_mount_holes();
            }
            translate([ -twodof_LED_mount_holes_dist_from_eachother,
                        twodof_face_plate_rounded_block_length/2
                        -twodof_LED_mount_holes_dist_from_eachother-10,0])
                face_front_rounded_rectangular_block_holes();
            translate([ twodof_LED_mount_holes_dist_from_eachother,
                        twodof_face_plate_rounded_block_length/2
                        -twodof_LED_mount_holes_dist_from_eachother-10,0])
                face_front_rounded_rectangular_block_holes();
            translate([0,2,30])
            rotate([90,90,0])
                face_front_rounded_rectangular_block_holes();
        }
    }

// TORSO BOTTOM AND MIDDLE SECTION
    // module to build torso bottom section front plate
    module torso_bottom_front_plate() {
        difference() {
            torso_bottom_rounded_rectangular_block();
            torso_bottom_cut_block();
            torso_bottom_block_remove_back();
        }
    }
    // module to build torso middle section front plate
    module torso_middle_front_plate() {
        difference() {
            torso_bottom_rounded_rectangular_block();
            torso_bottom_cut_block();
            torso_bottom_block_remove_back();
            translate([0,0,torso_bottom_rounded_block_height/2+torso_middle_rounded_block_height])
                cube([  torso_top_rounded_block_width+2,
                        torso_top_rounded_block_length+2,
                        torso_bottom_rounded_block_height], center=true);
        }
    }
    // module to subtract bolt holes from from torso bottom front plate
    module torso_bottom_front_plate_with_joint_holes() {
        difference() {
            torso_bottom_front_plate();
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        torso_bottom_rounded_block_height
                        -joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,0,
                        joint_bolt_hole_bottomedge_offsett-bolt_hole_radius])
                side_rounded_bolt_holes(torso_top_rounded_block_length
                                        +bottom_rounded_block_height);
            translate([ 0,0,torso_bottom_rounded_block_height
                        -joint_bolt_hole_bottomedge_offsett
                        -bolt_hole_radius])
                side_rounded_bolt_holes(torso_top_rounded_block_length
                                        +bottom_rounded_block_height);
        }
    }
    // module to subtract bolt holes from from torso middle front plate
    module torso_middle_front_plate_with_joint_holes() {
        difference() {
            torso_middle_front_plate();
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        torso_middle_rounded_block_height
                        -joint_bolt_hole_bottomedge_offsett])
            rotate([90,0,0])
                bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
            translate([ 0,0,joint_bolt_hole_bottomedge_offsett
                        -bolt_hole_radius])
                side_rounded_bolt_holes(torso_top_rounded_block_length
                                        +bottom_rounded_block_height);
            translate([ 0,0,torso_middle_rounded_block_height
                        -bolt_hole_radius
                        -joint_bolt_hole_bottomedge_offsett])
                side_rounded_bolt_holes(torso_top_rounded_block_length
                                        +bottom_rounded_block_height);
        }
    }
    // module to subtract mount holes for speaker
    module torso_bottom_front_plate_with_speaker_holes() {
        difference() {
            torso_bottom_front_plate_with_joint_holes();
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        torso_join_rounded_block_height/2
                        +speaker_hole_radius
                        +speaker_hole_edge_offset])
            rotate([90,0,0])
                speaker_holes(); 
        }
    }
    // module to subtract mount holes for jacks and amp
    module torso_bottom_front_plate_with_jacks_and_amp_holes() {
        translate([ 0,torso_bottom_rounded_block_height/2,
                    torso_top_cut_rounded_block_length/2
                    +bottom_rounded_block_height])
        rotate([90,0,0])
            difference() {
                torso_bottom_front_plate_with_speaker_holes();
                translate([ -torso_top_rounded_block_width/2
                            +bottom_rounded_block_height,0,
                            -((amp_weight_hole_length
                            +amp_weight_hole_radius
                            +amp_weight_hole_length/2
                            +amp_mount_hole_radius)/2
                            -(audio_jack_radius
                            +audio_jack_dist_from_center
                            +2*power_jack_radius
                            +power_jack_dist_from_center))
                            +torso_join_rounded_block_height/2
                            +speaker_hole_edge_offset+5])
                rotate([90,0,270])
                    jack_and_amp_mount_holes();
        }
    }
    // module to subtract mount holes for PWM board
    module torso_middle_front_plate_with_pwmboard_holes() {
        translate([ 0,torso_middle_rounded_block_height/2,
                    torso_top_cut_rounded_block_length/2
                    +bottom_rounded_block_height])
        rotate([90,0,0])
        difference() {
            torso_middle_front_plate_with_joint_holes();
            translate([ 0,-torso_top_rounded_block_length/2
                        +bottom_rounded_block_height,
                        +pwm_hole_dist_from_eachother
                        +bolt_hole_radius
                        +torso_join_rounded_block_height/2
                        +6.0])
            rotate([90,0,0])
                pwm_mount_holes(); 
        }
    }

// TORSO FEET SECTION
    // module for building torso bottom feet join section
    module torso_bottom_feet_section_compound() {
        difference() {
            torso_join_rounded_block();
            translate([ 0,0,
                        (torso_join_rounded_block_height+2)/2])
                torso_join_cut_block();
            torso_join_block_remove_back();
            translate([0,0, -torso_join_rounded_block_height/2
                            -bottom_rounded_block_height])
            cube([ torso_join_rounded_block_width+2,
                    torso_join_rounded_block_length+2,
                    torso_join_rounded_block_height], center = true);
        }
    }
    // module for subtracting join holes from torso bottom feet section
    module torso_bottom_feet_section_with_holes() {
        translate([0,0,bottom_rounded_block_height])
            difference() {
                torso_bottom_feet_section_compound();
                // top layer of holes
                translate([ 0,-torso_join_rounded_block_length/2
                            +bottom_rounded_block_height,
                            joint_bolt_hole_bottomedge_offsett])
                rotate([90,0,0])
                    bottom_rounded_bolt_holes(neck_bolt_hole_dist_from_center);
                translate([ 0,0,
                            joint_bolt_hole_bottomedge_offsett
                            -bolt_hole_radius])
                    side_rounded_bolt_holes(torso_top_rounded_block_length
                                            +2*bottom_rounded_block_height);
            }
    }
    // module for joingin feet and curved torso join section
    module torso_bottom_feet_section_final() {
        union() {
            translate([0,torso_join_rounded_block_length/2,0])
                torso_bottom_feet_section_with_holes();
            torso_pair_of_feet_plates();
        }
    }

// UPPER ARM 
    // module to build upper arm top section with spline hat
    module upper_arm_top_section_with_spline_hat() {
        difference() {
            union() {
                translate([0,0, top_rounded_block_height
                                +2*bottom_rounded_block_height])
                    spline_hat();
                translate([0,0, top_rounded_block_height
                                +3*bottom_rounded_block_height])
                    bearing_race_cup();
                upper_arm_top_rounded_rectangular_block();
            }
            translate([0,0, top_rounded_block_height
                            +2*bottom_rounded_block_height])
                spline_screw_hole();
        }
    }
    // module to build upper arm bottom section with motor mount hole
    module upper_arm_bottom_with_motor_mount_hole() {
        union() {
            difference() {
                upper_arm_bottom_rounded_rectangular_block();
                rotate([0,0,180])
                translate([elbow_motor_offset,0,0])
                    motor_body_top_cut_block_combined();
            } 
            translate([-elbow_motor_offset,0,top_rounded_block_height])
                bearing_race_cup();
        }
    }
    // module to build upper arm slim bottom clamp with motor mount hole
    module upper_arm_slim_bottom_with_motor_clamp_hole() {
        union() {
            difference() {
                upper_arm_bottom_rounded_rectangular_cap_section();
                rotate([0,0,180])
                translate([elbow_motor_offset,0,0])
                    motor_body_bottom_cut_block_combined();
            } 
            
        }
    }
    // module to build upper arm bottom section with bolt holes
    module upper_arm_bottom_with_bolt_holes() {
        difference() {
            upper_arm_bottom_with_motor_mount_hole();
            top_rounded_bolt_holes(upper_arm_bolts_dist_from_center);
            top_rounded_bolt_holes_countersink(upper_arm_bolts_dist_from_center);
        }
    }
    // module to build upper arm motor clamp bottom section with bolt holes
    module upper_arm_slim_bottom_with_bolt_holes() {
        difference() {
            upper_arm_slim_bottom_with_motor_clamp_hole();
            top_rounded_bolt_holes(upper_arm_bolts_dist_from_center);
            top_rounded_bolt_holes_countersink(upper_arm_bolts_dist_from_center);
        }
    }
    // module to build complete upper arm section
    module upper_arm_spline_hat_and_motor_block_complete() {
        translate([-12.35,0,0])
            union() {
                translate([ upper_arm_rounded_block_width/2,0,0])
                            upper_arm_bottom_with_bolt_holes();
                difference() {
                    translate([ -upper_arm_rounded_block_width/2
                                +upper_arm_join_offsett,0,0])
                        upper_arm_top_section_with_spline_hat();
                    translate([ upper_arm_join_offsett/2+1,0,
                                top_rounded_block_height/2])
                        cube([  upper_arm_join_offsett,
                                upper_arm_rounded_block_length+2,
                                top_rounded_block_height+2], center=true);
                }
            }
    }
    // module to build complete upper arm slim cap section
    module upper_arm_motor_clamp_block_complete() {
        translate([-12.35,0,0])
            union() {
                translate([upper_arm_rounded_block_width/2,0,0])
                    upper_arm_slim_bottom_with_bolt_holes();
                difference() {
                    translate([ -upper_arm_rounded_block_width/2
                                +upper_arm_join_offsett,0,0])
                        upper_arm_top_rounded_rectangular_cap_block();
                    translate([ upper_arm_join_offsett/2+1,0,
                                top_rounded_block_height/2])
                        cube([  upper_arm_join_offsett,
                                upper_arm_rounded_block_length+2,
                                top_rounded_block_height+2], center=true);
                }
            }
    }

// LOWER ARM 
    // module for lower arm bearing section
    module lower_arm_bearing_sectiion() {
        difference() {
            union() {
                translate([0,0,0])
                    spline_hat();
                translate([0,0,bottom_rounded_block_height])
                    bearing_race_cup();
                translate([0,0,bottom_rounded_block_height/2])
                    cylinder(   r = race_cup_radius+cup_block_width/2,
                                h = bottom_rounded_block_height, center = true);
                
            }
            translate([0,0,0])
                spline_screw_hole();
        }   
    }
    // module for lower arm motor mounting section
    module lower_arm_motor_mounting_sectiion() {
        difference() {
            lower_arm_rounded_rectangular_block();
            rotate([0,0,180])
            translate([-motor_body_cut_block_length/2+1,0,0])
                motor_body_top_cut_block_combined();
            top_rounded_bolt_holes(lower_arm_bolt_hole_dist_from_center);
            top_rounded_bolt_holes_countersink(lower_arm_bolt_hole_dist_from_center);
        }
    }
    // module for lower arm motor clamping section
    module lower_arm_motor_clamp() {
        difference() {
            lower_arm_slim_rounded_rectangular_block();
            rotate([0,0,180])
            translate([-motor_body_cut_block_length/2+1,0,0])
                motor_body_bottom_cut_block_combined();
            top_rounded_bolt_holes(lower_arm_bolt_hole_dist_from_center);
            
        }
    }
    // module for complete lower arm motor mount section
    module lower_arm_complete_motor_mount_section() {
        translate([26,0,0])
        rotate([90,0,0])
            union() {
                rotate([-90,0,0]) 
                translate([-lower_arm_strut_width - 6.5,0,0])
                    lower_arm_bearing_sectiion();
                translate([ 0,lower_rounded_block_length/2,
                            -top_rounded_block_height/2])
                    lower_arm_motor_mounting_sectiion();
                translate([-0.5,0,0])
                    difference() {
                        translate([ -lower_arm_strut_width/2 
                                    +lower_rounded_block_width/4,
                                    (bottom_rounded_block_height+cup_block_height)/2,0])
                            cube([  lower_arm_strut_width 
                                    +lower_rounded_block_width/2,
                                    bottom_rounded_block_height+cup_block_height,
                                    top_rounded_block_height],center=true);
                        rotate([-90,0,0]) 
                        translate([ -lower_arm_strut_width - 6.5,0,
                                    top_rounded_block_height/2-2])
                            cylinder(   r = race_cup_radius+cup_block_width/2,
                                        h = top_rounded_block_height, center = true);
                        translate([10,top_rounded_block_height/2,0])
                            cube([ lower_rounded_block_width,
                                    top_rounded_block_height+1,
                                    lower_rounded_block_length],center=true);

                }
            }
    }

// HAND    
    // module for adding thumb
    module hand_fingers_and_thumb () {
        union() {
            translate([-(5*(toe_width+toe_gap)-4*toe_gap)/2,-toe_length/2-4,0])
            scale([0.85,1.3,0.85])
                cube([  toe_width, toe_length, 
                        bottom_rounded_block_height], center=true);
            translate([-3.99,0,0])
            scale([0.875,1.0,0.85])
                cube([  5*(toe_width+toe_gap)-toe_gap, toe_length/2, 
                        bottom_rounded_block_height], center=true);
            hand_fingers();
        }
    }
    // module for adding a palm
    module hand_fingers_thumb_and_palm () {
        scale([0.75,0.75,1.0])
        union() {
            hand_fingers_and_thumb();
            hull() {
                translate([-3.99,2,0])
                scale([0.875,1.0,0.85])
                    cube([  5*(toe_width+toe_gap)-toe_gap, toe_length/2, 
                            bottom_rounded_block_height], center=true);
                translate([-3.99,20,0])
                scale([1.0,1.0,0.85])
                    cylinder(   r = 2*corner_radius, 
                                h = bottom_rounded_block_height, center = true);
            }
        }
    }
    // module for adding spline hat to hand
    module hand_complete_with_spline_hat () {
        translate([0,20,-0.15*bottom_rounded_block_height/2])
        difference() {
            union() {
                rotate([0,180,0])
                translate([2.9,-15,-bottom_rounded_block_height/2])
                    hand_fingers_thumb_and_palm();
                translate([0,0,-0.15*bottom_rounded_block_height/2])
                    spline_hat();
            }
            spline_screw_hole();
        }
    }
    