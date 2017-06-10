//-- Import ---------------------------------//
//-------------------------------------------//
include <01_parameters.scad>;

//-- Subtract Block Modules -----------------//
//-------------------------------------------//

// BEARING RACE
    // module to subtract the bearing race from bearing race block
    module bearing_race_cut_block() {
        translate([0,0, bearing_radius])
            rotate_extrude(convexity = 10)
                translate([race_cup_radius,0,0])
                    circle(r = bearing_radius, $fn = 40);
    }

// MOTOR BLOCK TOP SECTION
    // module to subtract motor body from top sections
    module motor_body_top_cut_block() {
        translate([ 0,0, top_cut_block_height/2 - 1])
            cube([  motor_body_cut_block_width, 
                    motor_body_cut_block_length, 
                    top_cut_block_height + 2], center = true);
    }
    // module to subtract the lugs of the motor body from the top section 
    module motor_body_top_cut_block_lugs() {
        translate([ 0,0, top_cut_block_height_lugs/2 - 1])
            cube([  top_cut_block_width_lugs, 
                    motor_body_cut_block_length, 
                    top_cut_block_height_lugs + 2], center = true);
    }
    // module to subtract the motor body central cylinder from the top section
    module motor_body_top_cut_block_cylinder() {
        translate([ -motor_body_cut_block_width/2 + motor_body_cut_block_length/2,0,
                    top_cut_block_height/2])
            cylinder(   h = top_rounded_block_height + 4, 
                        r = motor_body_cut_block_length/2, center = true);
    }
    // module to subtract the small cylindrical section from the the top section
    module motor_body_top_cut_block_small_cylinder() {
        translate([ top_cut_block_small_radius/2,0,
                    top_rounded_block_height/2])
            cylinder(   h = top_rounded_block_height + 4,
                        r = top_cut_block_small_radius, center = true);
    }
    // module to bridge the necgative gap between the clinders in the top section
    module motor_body_top_cut_block_join_cylinders() {
        translate([ 0,0, top_rounded_block_height/2])
            cube([  top_cut_block_small_radius, top_cut_block_small_radius*2, 
                    top_rounded_block_height + 4], center = true);
    }
    // module that combines all top section motor body elements into one subtraction block
    module motor_body_top_cut_block_combined() {
        translate([ +motor_body_cut_block_width/2 
                    -motor_body_cut_block_length/2,0,0])
            union() {
                motor_body_top_cut_block();
                motor_body_top_cut_block_lugs();
                motor_body_top_cut_block_cylinder();
                motor_body_top_cut_block_small_cylinder();
                motor_body_top_cut_block_join_cylinders();
            }
    }

// MOTOR BODY BOTTOM SECTION
    // module to subtract the motor body from bottom section of motor clamps
    module motor_body_bottom_cut_block_combined() {
        translate([ +motor_body_cut_block_width/2 
                    -motor_body_cut_block_length/2,0,0])
            union() {
                translate([ 0,0, bottom_rounded_block_height/2])
                    cube([  motor_body_cut_block_width, 
                            motor_body_cut_block_length, 
                            bottom_rounded_block_height + 2], center = true);
                translate([ -(motor_body_cut_block_width/2 + wire_cut_block_width/2) + 0.5,0,
                            bottom_rounded_block_height/2])
                    cube([  wire_cut_block_width + 1,
                            wire_cut_block_length, 
                            bottom_rounded_block_height + 2], center = true);
            }
    }

// TORSO TOP SECTION
    // module to hollow out torso top section
    module torso_top_cut_block() {
        translate([0,0,torso_top_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*torso_top_cut_rounded_block_width/2
                                    -x*torso_top_cut_corner_radius, 
                                    y*torso_top_cut_rounded_block_length/2
                                    -y*torso_top_cut_corner_radius, 0])
                            cylinder(   r = torso_top_cut_corner_radius,
                                        h = torso_top_rounded_block_height + 2, center = true);
                    }
                }
                cube([  torso_top_cut_rounded_block_width - 2*torso_top_cut_corner_radius, 
                        torso_top_cut_rounded_block_length, 
                        torso_top_rounded_block_height + 2], center = true);
                cube([  torso_top_cut_rounded_block_width, 
                        torso_top_cut_rounded_block_length - 2*torso_top_cut_corner_radius, 
                        torso_top_rounded_block_height + 2], center = true);       
            }
    }
    // module to cut the back off torso top block
    module torso_top_block_remove_back() {
        translate([ 0,torso_top_rounded_block_length - bottom_rounded_block_height,
                    torso_top_rounded_block_height/2])
            cube([  torso_top_cut_rounded_block_width + 2*bottom_rounded_block_height + 2,
                    torso_top_rounded_block_length + 2*torso_top_cut_corner_radius,
                    torso_top_rounded_block_height + 1], center=true);
    }
    // module to cut the back off torso join section
    module torso_join_block_remove_back() {
        translate([ 0,torso_top_rounded_block_length,
                    0])
            cube([  torso_join_cut_rounded_block_width + 2*bottom_rounded_block_height + 2,
                    torso_join_rounded_block_length + 2*torso_top_cut_corner_radius,
                    torso_join_rounded_block_height + 1], center=true);
    }

// TORSO JOIN SECTION
    // module to hollow out torso join section
    module torso_join_cut_block() {
        translate([0,0,0])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*torso_join_cut_rounded_block_width/2
                                    -x*torso_join_cut_corner_radius, 
                                    y*torso_join_cut_rounded_block_length/2
                                    -y*torso_join_cut_corner_radius, 0])
                            cylinder(   r = torso_join_cut_corner_radius,
                                        h = torso_join_rounded_block_height
                                        +2, center = true);
                    }
                }
                cube([  torso_join_cut_rounded_block_width
                        -2*torso_join_cut_corner_radius, 
                        torso_join_cut_rounded_block_length, 
                        torso_join_rounded_block_height + 2], center = true);
                cube([  torso_join_cut_rounded_block_width, 
                        torso_join_cut_rounded_block_length
                        -2*torso_join_cut_corner_radius, 
                        torso_join_rounded_block_height + 2], center = true);       
            }
    }

// SPLINE HAT ASSEMBLY
    // module to subtract axle hole from right axle block 
    module axle_cylinder_cut_right_axle_block() {
        translate([ -motor_body_cut_block_width/2
                    +motor_body_cut_block_length/2,0,
                    twodof_left_axle_thick_block_height/2])
            cylinder(   h = twodof_left_axle_thick_block_height+2, 
                        r = twodof_right_axle_hole_radius, center = true);
    }

// MOUNT HOLES 
    // module to layout mount holes for arduino
    module arduino_mount_holes () {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                translate([x_tl,y_tl])
                    cylinder(   r = arduino_mount_hole_radius,
                                h = bottom_rounded_block_height + 2, center = true);
                translate([x_tr,y_tr])
                    cylinder(   r = arduino_mount_hole_radius,
                                h = bottom_rounded_block_height + 2, center = true);
                translate([x_bl,y_bl])
                    cylinder(   r = arduino_mount_hole_radius,
                                h = bottom_rounded_block_height + 2, center = true);
                translate([x_br,y_br])
                    cylinder(   r = arduino_mount_hole_radius,
                                h = bottom_rounded_block_height + 2, center = true);
        }
    }
    // module to build rounded block for front section weight reduction
    module torso_top_block_reduce_front_weight() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*(mount_hole_gap_width - 10)/2 - x*corner_radius, 
                                    y*(mount_hole_gap_length)/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height + 2, center = true);
                    }
                }
                cube([  (mount_hole_gap_width - 10) - 2*corner_radius, 
                        mount_hole_gap_length, 
                        bottom_rounded_block_height + 2], center = true);
                cube([  mount_hole_gap_width - 10, 
                        mount_hole_gap_length - 2*corner_radius, 
                        bottom_rounded_block_height + 2], center = true);       
            }
    }
    
// BOLT HOLES 
    // module array to subtract bolt holes from top sections
    module top_rounded_bolt_holes(bolt_hole_dist_from_center) {
        for (x = [-1,+1]) {
            translate([ x * bolt_hole_dist_from_center,0,
                        top_bolt_hole_height/2])
                cylinder(   r = bolt_hole_radius, 
                            h = top_bolt_hole_height+2, center = true);
        }
    }
    // module array to subtract bolt hole countersinks from top sections
    module top_rounded_bolt_holes_countersink(bolt_hole_dist_from_center) {
        for (x = [-1,+1]) {
            translate([ x*bolt_hole_dist_from_center,0, 
                        top_rounded_block_height - countersink_hole_depth/2 + 1])
                cylinder(   r = countersink_hole_radius, 
                            h = countersink_hole_depth+2 , center = true);
        }
    }
    // module array to subtract bolt holes from bottom sections
    module bottom_rounded_bolt_holes(bolt_hole_dist_from_center) {
        for (x = [-1,+1]) {
            translate([ x*bolt_hole_dist_from_center,0,
                        bottom_bolt_hole_height/2])
                cylinder(   r = bolt_hole_radius, 
                            h = bottom_bolt_hole_height+2, center = true);
        }
    }
    // module array to subtract bolt holes for side joins
    module side_rounded_bolt_holes(bolt_hole_dist_from_center) {
        for (x = [-1,+1]) {
            translate([ x*bolt_hole_dist_from_center,0,
                        bottom_bolt_hole_height/2])
            rotate([0,90,0])
                cylinder(   r = bolt_hole_radius, 
                            h = bottom_bolt_hole_height+2, center = true);
        }
    }
    // module array to subtract bolt holes from spline hat section
    module spline_hat_bolt_holes(bolt_hole_dist_from_center) {
        for (x = [-1,+1]) {
            translate([ x*bolt_hole_dist_from_center,0,
                        spline_hat_bolt_hole_height/2])
                cylinder(   r = bolt_hole_radius, 
                            h = spline_hat_bolt_hole_height+2, center = true);
        }
    }
    // module to subtract screw hole from spline
    module spline_screw_hole(){
        translate([0,0,bottom_rounded_block_height/2])
            cylinder(   h = bottom_rounded_block_height+2, 
                        r = spline_screw_hole_radius, $fn=50, center = true);
    }
    // module array to subtract bolt holes from twodof motor mount sections
    module twodof_join_holes(bolt_hole_dist_from_center) {
        for (y = [-1,+1]) {
            translate([ -motor_body_cut_block_width/2
                        +motor_body_cut_block_length/2,
                        y*bolt_hole_dist_from_center,
                        top_bolt_hole_height/2])
                cylinder(   r = bolt_hole_radius, 
                            h = top_bolt_hole_height+2, center = true);
        }
    }
    
// FACE
    // module to subtract join holes from twodof top plate mount 
    module cut_bolt_holes_from_top_plate_mount(dist_from_cent,dist_from_eachother) {
        for (x = [-1, +1]) {
            for (y = [-1, +1]) {
                translate([ x*dist_from_cent,
                            y*dist_from_eachother,
                            bottom_rounded_block_height/2])
                cylinder(   r = bolt_hole_radius,
                            h = bottom_rounded_block_height+1, center = true);
            }
        }
    }
    // module to build front rounded blocks to subtract from face front
    module face_front_rounded_rectangular_block_holes() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*2*(twodof_LED_mount_holes_dist_from_center-3)/2 - x*corner_radius, 
                                    y*2*(twodof_LED_mount_holes_dist_from_eachother-3)/2 - y*corner_radius,0])
                            cylinder(   r = corner_radius,
                                        h = bottom_rounded_block_height+2, center = true);
                    }
                }
                cube([  2*(twodof_LED_mount_holes_dist_from_center-3) - 2*corner_radius, 
                        2*(twodof_LED_mount_holes_dist_from_eachother-3), 
                        bottom_rounded_block_height+20], center = true);
                cube([  2*(twodof_LED_mount_holes_dist_from_center-3), 
                        2*(twodof_LED_mount_holes_dist_from_eachother-3) - 2*corner_radius, 
                        bottom_rounded_block_height+20], center = true);       
            }
    }

// TORSO BOTTOM AND MIDDLE SECTION
    // module to hollow out torso bottom section
    module torso_bottom_cut_block() {
        translate([0,0,torso_bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*torso_top_cut_rounded_block_width/2
                                    -x*torso_top_cut_corner_radius, 
                                    y*torso_top_cut_rounded_block_length/2
                                    -y*torso_top_cut_corner_radius, 0])
                            cylinder(   r = torso_top_cut_corner_radius,
                                        h = torso_bottom_rounded_block_height + 2, center = true);
                    }
                }
                cube([  torso_top_cut_rounded_block_width - 2*torso_top_cut_corner_radius, 
                        torso_top_cut_rounded_block_length, 
                        torso_bottom_rounded_block_height + 2], center = true);
                cube([  torso_top_cut_rounded_block_width, 
                        torso_top_cut_rounded_block_length - 2*torso_top_cut_corner_radius, 
                        torso_bottom_rounded_block_height + 2], center = true);       
            }
    }
    // module to cut the back off torso bottom block
    module torso_bottom_block_remove_back() {
        translate([ 0,torso_top_rounded_block_length - bottom_rounded_block_height,
                    torso_bottom_rounded_block_height/2])
            cube([  torso_top_cut_rounded_block_width + 2*bottom_rounded_block_height + 2,
                    torso_top_rounded_block_length + 2*torso_top_cut_corner_radius,
                    torso_bottom_rounded_block_height + 1], center=true);
    }
    // module to remove holes for speaker
    module speaker_holes() {
        translate([0,0,bottom_rounded_block_height/2])
            union() {
                cylinder(   r = speaker_hole_radius,
                            h = bottom_rounded_block_height+2,
                            $fn=50, center = true);
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*speaker_bolt_holes_dist_from_center, 
                                    y*speaker_bolt_holes_dist_from_center,0])
                            cylinder(   r = bolt_hole_radius, 
                                        h = bottom_rounded_block_height+2, center = true);
                    }
                }
            }
    }
    // module to remove holes to mount PWM board and weight saver
    module pwm_mount_holes() {
        translate([ 0,0,bottom_rounded_block_height/2])
            union() {
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*pwm_hole_dist_from_center, 
                                    y*pwm_hole_dist_from_eachother,0])
                            cylinder(   r = bolt_hole_radius, 
                                        h = bottom_rounded_block_height+2, center = true);
                    }
                }
                for (x = [-1, +1]) {
                    for (y = [-1, +1]) {
                        translate([ x*(pwm_hole_dist_from_center-7), 
                                    y*(pwm_hole_dist_from_eachother-7),0])
                            cylinder(   r = corner_radius, 
                                        h = bottom_rounded_block_height+2, center = true);
                    }
                }
                cube([  2*(pwm_hole_dist_from_center-7)+2*corner_radius,
                        2*(pwm_hole_dist_from_eachother-7),
                        bottom_rounded_block_height+2], center=true);
                cube([  2*(pwm_hole_dist_from_center-7),
                        2*(pwm_hole_dist_from_eachother-7)+2*corner_radius,
                        bottom_rounded_block_height+2], center=true);
            }
        }
    // module to remove holes to audio and power jacks and amplifier board
    module jack_and_amp_mount_holes() {
        translate([ 0,
                        -((amp_weight_hole_length
                        +amp_weight_hole_radius
                        +amp_weight_hole_length/2
                        +amp_mount_hole_radius)/2
                        -(audio_jack_radius
                        +audio_jack_dist_from_center
                        +2*power_jack_radius
                        +power_jack_dist_from_center)/2),
                        bottom_rounded_block_height/2])
            union() {
                translate([0,amp_weight_hole_length/2+amp_weight_hole_radius,0])
                    union() {
                        for (x = [-1, +1]) {
                            for (y = [-1, +1]) {
                                translate([ x*(amp_weight_hole_width/2), 
                                            y*(amp_weight_hole_length/2),0])
                                    cylinder(   r = amp_weight_hole_radius, 
                                                h = bottom_rounded_block_height+2, 
                                                center = true);
                            }
                        }
                        cube([  amp_weight_hole_width+2*amp_weight_hole_radius,
                                amp_weight_hole_length,
                                bottom_rounded_block_height+2], center=true);
                        cube([  amp_weight_hole_width,
                                amp_weight_hole_length+2*amp_weight_hole_radius,
                                bottom_rounded_block_height+2], center=true);
                        for (x = [-1, +1]) {
                            translate([ x*(amp_mount_hole_dist_from_eachother/2), 
                                        amp_weight_hole_length+3.8/2,0])
                                cylinder(   r = amp_mount_hole_radius, 
                                            h = bottom_rounded_block_height+2, 
                                            center = true);         
                        }
                    }
                union() {
                    translate([0,   -audio_jack_radius
                                    -audio_jack_dist_from_center,0])
                        cylinder(   r = audio_jack_radius, 
                                    h = bottom_rounded_block_height+2, center = true);
                    translate([0,   -audio_jack_radius
                                    -audio_jack_dist_from_center,
                                    -bottom_rounded_block_height-1
                                    +audio_jack_countersink_depth])
                        cylinder(   r = audio_jack_countersink_radius, 
                                    h = bottom_rounded_block_height+2, center = true);
                    translate([0,   -audio_jack_radius
                                    -audio_jack_dist_from_center
                                    -power_jack_radius
                                    -power_jack_dist_from_center,0])
                        cylinder(   r = power_jack_radius, 
                                    h = bottom_rounded_block_height+2, center = true);
                }
            }
    }