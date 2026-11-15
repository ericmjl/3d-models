// =====================================================================
//  Reward-chart token board  ("Bear Buddy" and "Bunny Buddy" token boards)
//  Parametric OpenSCAD model. All units in millimetres.
//
//  A board with 7 numbered token cups and an animal head on top stands in two
//  weighted paw feet, leaning back by `lean` degrees. Each time the child earns a
//  sticker, they take a token from the pot and drop it into the next cup.
//
//  Themes (select with -D 'theme="..."'); the mechanics, sizes and print orientation
//  are shared, only the decoration changes:
//    "bear"  (default) - bear head with round ears, bear-face tokens, bear-paw feet,
//                        beehive honey pot.
//    "bunny"           - bunny head with tall ears, bunny-face tokens, bunny-paw feet
//                        (long oval toes), carrot pot (carrot rings and a leafy top).
//  The bunny's tall ears are a flat outline in the plane of the board, like the bear's
//  head, so they print flat on the bed with nothing overhanging.
//
//  Assembly coordinates:  X = across (the child stands at +Y, so +X is on their left)
//                         Y = forward, towards the child
//                         Z = up
//  Board coordinates (also its print orientation, lying on its back):
//                         u = across, left to right as the child sees it
//                         v = up the board (bottom edge at v = 0)
//                         n = out of the front face (the back face is on the bed)
//
//  Printable parts (select with -D 'part="..."'), each exported in print orientation:
//    "board"    - the token board. Prints flat on its back: a 1.6 mm floor (solid,
//                 nothing to bridge) stiffened by a raised frame and the cup rims.
//                 Every feature rises straight up from the bed, so nothing overhangs.
//    "foot"     - bear-paw stand (print 2; the plate has 2). Holds the board's bottom
//                 edge in a slot that leans back. Open-top weight bay at the back.
//                 Prints as it stands.
//    "pot"      - honey pot that holds the unused tokens in a stack, with a finger
//                 slot in the front. Prints as it stands.
//    "token"    - one bear medallion token (print 7; the plate has 7). Prints face up.
//    "assembly" - everything in place (preview only)
//    "plate"    - every part in print orientation, as on the print plate (preview only)
//
//  Zero-support rules: the board and tokens only have vertical walls and upward
//  faces. The foot's slot leans back 12 degrees (its front wall overhangs by 12 deg
//  from vertical). The pot's beehive bands step out at 56 degrees from horizontal and
//  its finger slot has a rounded (upward-facing) bottom.
// =====================================================================

part = "assembly";
theme = "bear";        // "bear" or "bunny"

// ---------------------------------------------------------------------
// 1. TOKENS
// ---------------------------------------------------------------------
n_tokens     = 7;      // number of cups on the board (and tokens to print)
token_d      = 46.0;   // token diameter (choking-hazard rule: keep >= 45)
token_th     = 4.4;    // token thickness at its rim (easy to grab)
token_rim_w  = 2.4;    // round rim of the medallion
token_head_t = 2.6;    // bear head in the middle, held by three spokes
token_spoke_w= 3.6;
token_chamfer= 0.6;    // top edge chamfer of the rim

// ---------------------------------------------------------------------
// 2. BOARD
// ---------------------------------------------------------------------
lean         = 12;     // the board leans back this many degrees from vertical
floor_t      = 1.6;    // board floor: 8 solid layers, so no infill or bridging to print
edge_rib_w   = 2.4;    // raised frame around the board's edge (stiffens the thin floor)
edge_t       = 6.0;    // board thickness at the frame; the feet grip this edge
cup_clr      = 1.0;    // radial clearance between a token and its cup
rim_w        = 2.4;    // cup rim width (4 wall lines + 1 gap line: prints fast)
rim_h        = 6.5;    // rim height above the cup floor (the token is 4.4 mm thick)
rim_up_deg   = 25;     // rim arms rise this far above each cup's horizontal centre line
cup_wall     = 3.0;    // minimum wall between two neighbouring cups in a row
bottom_n     = 4;      // cups in the bottom row (the rest go in the top row)
margin       = 2.0;    // board border around the cup rims (rims overlap the frame)

num_size     = 18;     // engraved cup numbers
num_depth    = 0.6;    // 3 layers deep, leaving 1 mm of floor
num_font     = "Liberation Sans:style=Bold";

head_r       = 19.0;   // bear head on top of the board
head_up      = 34.0;   // head centre above the top-row cup centres
ear_r        = 7.5;
ear_dist     = 19.5;   // ear centre distance from the head centre
ear_ang      = 40;     // ear angle from vertical
face_h       = 2.4;    // how far the snout stands out of the head (eyes a bit more)

// bunny theme: head and tall ears (all in the plane of the board)
bun_head_r   = 17.0;   // bunny head
bun_head_up  = 33.0;   // head centre above the top-row cup centres
bun_ear_rx   = 7.5;    // ear half width
bun_ear_ry   = 24.0;   // ear half length (tall ears)
bun_ear_x    = 9.0;    // ear centres +/- this far from the middle
bun_ear_up   = 30.0;   // ear centres above the head centre
bun_ear_tilt = 12;     // ears lean outwards by this many degrees (still flat on the bed)

// ---------------------------------------------------------------------
// 3. FEET (bear-paw stands)
// ---------------------------------------------------------------------
foot_u       = 51.0;   // feet centres, +/- this far from the board's centre line;
                       //   halfway between two bottom-row cups, where the rims are high
slot_clr     = 0.25;   // clearance each side of the board's edge in the slot
foot_floor   = 4.0;    // material under the board's bottom edge
foot_h       = 13.0;   // height of the paw (the rear wall the board leans on)
foot_hw      = 18.0;   // half width of the paw pad
foot_back    = 46.0;   // pad reaches this far behind the board's front face
lip_hw       = 10.0;   // narrow front lip that stops the board sliding forward
lip_h        = 6.0;    //   ... its height above the slot floor (stays under the rims)
lip_t        = 5.0;
toe_r        = 5.0;    // three toes in front, low enough to pass under the rims
toe_h        = 2.0;    //   ... toe height above the slot floor
bun_toe_long = 1.35;   // bunny theme: toes stretched into long ovals
bay_hw       = 11.5;   // open-top weight bay, as far forward as possible: weight near
bay_y0       = -40.0;  //   the board resists tipping backwards best
bay_y1       = -6.0;
bay_floor    = 1.6;

// ---------------------------------------------------------------------
// 4. HONEY POT (holds the unused tokens)
// ---------------------------------------------------------------------
pot_clr      = 1.5;    // radial clearance around the stacked tokens
pot_wall     = 1.6;    // wall: exactly 4 wall lines; follows the beehive bands
pot_floor    = 1.6;
pot_spare    = 3.0;    // headroom above a full stack of tokens
pot_bands    = 4;      // beehive-style bands on the outside
pot_band_out = 1.2;    // how far each band steps out (rises at 56 deg: no support)
pot_slot_w   = 22.0;   // finger slot in the front, to slide tokens up and out
pot_slot_z   = 10.0;   // bottom of the finger slot (the U's lowest point)
// bunny theme: carrot pot = finer carrot rings plus a leafy crown at the back of the rim
carrot_bands = 6;
carrot_band_out = 0.9;
leaf_h       = 12.0;   // height of the leafy crown above the rim (same 1.6 mm wall)

$fn = 64;

// ---------------------------------------------------------------------
// DERIVED
// ---------------------------------------------------------------------
R_in   = token_d / 2 + cup_clr;
R_out  = R_in + rim_w;
pitch  = 2 * R_in + cup_wall;
top_n  = n_tokens - bottom_n;
// top-row rims must clear the bottom-row token openings
row_gap = ceil(sqrt(pow(R_in + R_out + 1, 2) - pow(pitch / 2, 2)));
v_row1 = R_out + margin;
v_row2 = v_row1 + row_gap;
v_head = v_row2 + (theme == "bunny" ? bun_head_up : head_up);
// cup centres [u, v]; numbered bottom row first, left to right
cups = concat(
    [for (i = [0 : bottom_n - 1]) [(i - (bottom_n - 1) / 2) * pitch, v_row1]],
    [for (i = [0 : top_n - 1])    [(i - (top_n - 1) / 2) * pitch, v_row2]]);
pot_ri   = token_d / 2 + pot_clr;
pot_ro   = pot_ri + pot_wall;
n_bands  = theme == "bunny" ? carrot_bands : pot_bands;
band_out = theme == "bunny" ? carrot_band_out : pot_band_out;
pot_h    = pot_floor + n_tokens * token_th + pot_spare;
// assembly preview positions
foot_z   = foot_floor;                 // the board's bottom edge sits at this height
pot_x    = -(max([for (c = cups) abs(c[0])]) + R_out + margin + 18 + pot_ro);
pot_y    = 0;

echo(VIEWER_PARAMS = [
    ["lean", lean], ["floor_t", floor_t], ["edge_t", edge_t], ["foot_z", foot_z], ["foot_u", foot_u],
    ["token_d", token_d], ["token_t", token_th], ["rim_h", rim_h], ["R_in", R_in],
    ["cups", cups], ["pot_x", pot_x], ["pot_y", pot_y], ["pot_floor", pot_floor],
    ["pot_h", pot_h], ["pot_ri", pot_ri], ["v_head", v_head],
    ["head_r", theme == "bunny" ? bun_head_r : head_r], ["theme", theme]]);

// ---------------------------------------------------------------------
// HELPERS
// ---------------------------------------------------------------------
// Stand the flat board up: board coordinates (u, v, n) -> assembly coordinates.
// rotate([0,180,0]) turns the face towards the child with u running left to right
// as they see it; then the board is stood up, leant back, and lifted onto the feet.
module board_pose() {
    translate([0, 0, foot_z]) rotate([90 + lean, 0, 0]) rotate([0, 180, 0]) children();
}

module rounded_rect2d(x0, y0, x1, y1, r) {
    hull() for (x = [x0 + r, x1 - r], y = [y0 + r, y1 - r]) translate([x, y]) circle(r);
}

// ---------------------------------------------------------------------
// BOARD (flat, face up)
// ---------------------------------------------------------------------
module head2d() {
    if (theme == "bunny") bunny_head2d();
    else translate([0, v_head]) {
        circle(head_r);
        for (s = [-1, 1]) rotate(-s * ear_ang) translate([0, ear_dist]) circle(ear_r);
    }
}

// bunny head with two tall ears, a flat outline in the plane of the board
module bunny_head2d() {
    translate([0, v_head]) {
        circle(bun_head_r);
        for (s = [-1, 1]) translate([s * bun_ear_x, bun_ear_up]) rotate(-s * bun_ear_tilt)
            scale([bun_ear_rx, bun_ear_ry]) circle(1, $fn = 96);
    }
}

module board_outline2d() {
    hull() for (c = cups) translate(c) circle(R_out + margin);
    head2d();
}

module cup_rim(c) {
    // the lower U, with arms that rise rim_up_deg above the centre line
    translate([c[0], c[1], floor_t - 0.01]) rotate(-180 - rim_up_deg)
        rotate_extrude(angle = 180 + 2 * rim_up_deg, $fn = 120)
            translate([R_in, 0]) square([rim_w, rim_h + 0.01]);
}

module bear_face() {
    translate([0, v_head, floor_t - 0.01]) {
        for (s = [-1, 1]) translate([s * 7, 3.5, 0]) cylinder(r = 2.6, h = face_h + 0.6);  // eyes
        translate([0, -5.5, 0]) {                                                          // snout
            scale([1.3, 1, 1]) cylinder(r = 6.0, h = face_h);
            translate([0, 1.6, 0]) scale([1.4, 1, 1]) cylinder(r = 2.1, h = face_h + 1.4);  // nose
        }
    }
}

module smile_engrave() {   // pressed into the top of the snout
    translate([0, v_head - 7.3, floor_t + face_h - 0.6]) linear_extrude(1)
        for (s = [-1, 1]) translate([s * 2.1, 0]) difference() {
            circle(2.3, $fn = 40); circle(1.4, $fn = 40); translate([-5, 0]) square(10);
        }
}

module bunny_face() {
    translate([0, v_head, floor_t - 0.01]) {
        for (s = [-1, 1]) translate([s * 6.5, 3.0, 0]) cylinder(r = 2.4, h = face_h + 0.6);  // eyes
        for (s = [-1, 1]) translate([s * 3.6, -5.5, 0]) cylinder(r = 4.0, h = face_h);       // cheeks
        translate([0, -1.6, 0]) scale([1.3, 1, 1]) cylinder(r = 1.9, h = face_h + 1.0);       // nose
    }
}

module bunny_mouth_engrave() {   // a little "w" pressed into the cheeks
    translate([0, v_head - 6.8, floor_t + face_h - 0.6]) linear_extrude(1)
        for (s = [-1, 1]) translate([s * 1.7, 0]) difference() {
            circle(1.9, $fn = 40); circle(1.1, $fn = 40); translate([-5, 0]) square(10);
        }
}

module spokes2d(r, w) {   // three spokes: left, right and down
    for (a = [0, 180, 270]) rotate(a) translate([0, -w / 2]) square([r, w]);
}

module board_part() {
    difference() {
        union() {
            linear_extrude(floor_t) board_outline2d();
            // raised frame around the edge
            linear_extrude(edge_t) difference() {
                board_outline2d();
                offset(r = -edge_rib_w) board_outline2d();
            }
            for (c = cups) cup_rim(c);
            if (theme == "bunny") bunny_face(); else bear_face();
        }
        // the token pockets (also clears a neighbour's rim out of each cup)
        for (c = cups) translate([c[0], c[1], floor_t]) cylinder(r = R_in, h = rim_h + 1, $fn = 120);
        // engraved cup numbers
        for (i = [0 : n_tokens - 1]) translate([cups[i][0], cups[i][1], floor_t - num_depth])
            linear_extrude(num_depth + 1)
                text(str(i + 1), size = num_size, font = num_font, halign = "center", valign = "center");
        if (theme == "bunny") bunny_mouth_engrave(); else smile_engrave();
    }
}

// ---------------------------------------------------------------------
// FOOT (bear paw; prints as it stands)
// ---------------------------------------------------------------------
// The board's cross-section in the foot's Y-Z plane (front face through y = 0 at the
// slot floor), grown by the slot clearance, and long enough to cut through the top.
module slot_cut() {
    translate([0, 0, foot_floor]) rotate([90 + lean, 0, 0]) rotate([0, 180, 0])
        translate([-50, -1, -slot_clr]) cube([100, 60, edge_t + 2 * slot_clr]);
}

module foot_part() {
    difference() {
        union() {
            // paw pad behind the board (rounded, top edge chamfered)
            hull() {
                linear_extrude(foot_h - 1.5)
                    rounded_rect2d(-foot_hw, -foot_back, foot_hw, 1, 11);
                linear_extrude(foot_h)
                    rounded_rect2d(-foot_hw + 1.5, -foot_back + 1.5, foot_hw - 1.5, -0.5, 9.5);
            }
            // narrow front lip, in front of the board's bottom edge
            linear_extrude(foot_floor + lip_h)
                rounded_rect2d(-lip_hw, -2, lip_hw, edge_t + lip_t, 2.5);
            // three low toes
            for (a = [-40, 0, 40]) translate([sin(a) * 12, edge_t + lip_t - 2 + cos(a) * 6, 0])
                if (theme == "bunny")   // long bunny toes, pointing the way each toe faces
                    rotate(-a) scale([0.8, bun_toe_long, 1]) cylinder(r = toe_r, h = foot_floor + toe_h);
                else
                    cylinder(r = toe_r, h = foot_floor + toe_h);
        }
        slot_cut();
        // open-top weight bay (glue the weights in!)
        translate([0, 0, bay_floor]) linear_extrude(foot_h)
            rounded_rect2d(-bay_hw, bay_y0, bay_hw, bay_y1, 5);
    }
}

// ---------------------------------------------------------------------
// HONEY POT (prints as it stands)
// ---------------------------------------------------------------------
// Wall profile: beehive bands. Each band steps out by pot_band_out while rising (56
// degrees from horizontal), runs straight up, then steps back in (upward facing).
// The inside follows the outside, so the wall stays pot_wall thick everywhere.
function pot_outer_pts() =
    let(z_start = pot_floor + 0.5, band_h = (pot_h - z_start - 1.5) / n_bands,
        rise = band_out * 1.5)
    concat([[pot_ro, 0]],
        [for (i = [0 : n_bands - 1], k = [0 : 2])
            let(z0 = z_start + i * band_h)
            k == 0 ? [pot_ro, z0] :
            k == 1 ? [pot_ro + band_out, z0 + rise] :
                     [pot_ro + band_out, z0 + band_h - rise]],
        [[pot_ro, pot_h - 1.5 + 0.01], [pot_ro, pot_h]]);

module pot_profile2d() {
    outer = pot_outer_pts();
    inner = [for (i = [len(outer) - 1 : -1 : 0])
        [outer[i][0] - pot_wall, max(outer[i][1], pot_floor)]];
    polygon(concat([[0, 0]], outer, inner, [[0, pot_floor]]));
}

// Carrot leaves for the bunny's pot: a crown of three leaves, seen from behind. Each leaf
// narrows towards its tip, so no edge of the outline faces downwards.
module leaves2d() {
    hull() { translate([-6, 0]) square([12, 0.01]); translate([0, leaf_h - 2]) circle(2, $fn = 24); }
    for (s = [-1, 1]) hull() {
        translate([s * 9 - 5.5, 0]) square([11, 0.01]);
        translate([s * 12, leaf_h * 0.78 - 2]) circle(2, $fn = 24);
    }
    translate([-15, 0]) square([30, 3]);   // all three join in a band on the rim
}

module carrot_leaves() {
    // the pot's top wall (pot_ri..pot_ro) carried on upwards at the back, cut to the
    // leaf outline; it sits exactly on the wall below
    translate([0, 0, pot_h - 0.01]) intersection() {
        difference() {
            cylinder(r = pot_ro, h = leaf_h + 1, $fn = 120);
            translate([0, 0, -1]) cylinder(r = pot_ri, h = leaf_h + 3, $fn = 120);
        }
        rotate([90, 0, 0]) linear_extrude(pot_ro + 2) leaves2d();
    }
}

module pot_part() {
    if (theme == "bunny") carrot_leaves();
    difference() {
        rotate_extrude($fn = 120) pot_profile2d();
        // finger slot at the front (+Y): a U, open at the top
        hull() {
            translate([0, 0, pot_slot_z + pot_slot_w / 2]) rotate([-90, 0, 0])
                cylinder(r = pot_slot_w / 2, h = pot_ro + 10, $fn = 48);
            translate([-pot_slot_w / 2, 0, pot_h - 1]) cube([pot_slot_w, pot_ro + 10, 10]);
        }
    }
}

// ---------------------------------------------------------------------
// TOKEN (bear medallion, prints face up)
// ---------------------------------------------------------------------
// A bear medallion: a round rim (the full 46 mm, easy to grab) with a bear head in
// the middle on three spokes. The open windows save a lot of print time.
module token_head2d() {
    if (theme == "bunny") {
        // bunny head; the tips of the tall ears run into the rim, which holds them firm
        translate([0, -3]) circle(10.5);
        for (s = [-1, 1]) translate([s * 4.8, 10.5]) rotate(-s * 10) scale([3.8, 11.2]) circle(1, $fn = 48);
    } else {
        translate([0, -1.5]) circle(12.0);
        for (s = [-1, 1]) translate([s * 9.3, 8.4]) circle(5.2);
    }
}

module token_face_pits2d() {
    if (theme == "bunny") {
        for (s = [-1, 1]) translate([s * 4.2, -1.2]) circle(1.5, $fn = 24);             // eyes
        translate([0, -5.0]) scale([1.3, 1]) circle(1.4, $fn = 24);                     // nose
        translate([0, -7.6]) for (s = [-1, 1]) translate([s * 1.5, 0]) difference() {  // mouth
            circle(1.9, $fn = 32); circle(1.0, $fn = 32); translate([-5, 0]) square(10);
        }
        for (s = [-1, 1]) translate([s * 4.8, 11]) rotate(-s * 10) scale([1.4, 6.5]) circle(1, $fn = 32);  // inner ears
    } else {
        for (s = [-1, 1]) translate([s * 4.4, 0.9]) circle(1.6, $fn = 24);
        translate([0, -3.8]) scale([1.4, 1]) circle(1.9, $fn = 24);
        translate([0, -6.6]) difference() {
            circle(3.4, $fn = 40); circle(2.4, $fn = 40); translate([-5, 0]) square(10);
        }
    }
}

module token_part() {
    r = token_d / 2;
    // rim with a chamfered top edge
    difference() {
        union() {
            cylinder(r = r, h = token_th - token_chamfer, $fn = 120);
            translate([0, 0, token_th - token_chamfer - 0.01])
                cylinder(r1 = r, r2 = r - token_chamfer, h = token_chamfer + 0.01, $fn = 120);
        }
        translate([0, 0, -1]) cylinder(r = r - token_rim_w, h = token_th + 2, $fn = 120);
    }
    // head and spokes, with eyes, nose and mouth pressed in
    difference() {
        linear_extrude(token_head_t) {
            token_head2d();
            translate([0, -1.5]) spokes2d(r - 2, token_spoke_w);   // ends inside the rim
        }
        translate([0, 0, token_head_t - 0.6]) linear_extrude(1) token_face_pits2d();
    }
}

// ---------------------------------------------------------------------
// LAYOUTS
// ---------------------------------------------------------------------
// preview colours: bear = sky blue + yellow, bunny = lavender + white
c_board = theme == "bunny" ? "#b9a3e3" : "#5bb8f0";
c_pot   = theme == "bunny" ? "#fbf7ff" : "#ffc93c";
c_token = theme == "bunny" ? "#ffffff" : "#ffd95a";

module assembly() {
    color(c_board) board_pose() board_part();
    for (s = [-1, 1]) color(c_board) translate([s * foot_u, 0, 0]) foot_part();
    color(c_pot) translate([pot_x, pot_y, 0]) pot_part();
    // three tokens already earned, the rest stacked in the pot
    for (i = [0 : 2]) color(c_token)
        board_pose() translate([cups[i][0], cups[i][1], floor_t]) token_part();
    for (i = [3 : n_tokens - 1]) color(c_token)
        translate([pot_x, pot_y, pot_floor + (i - 3) * token_th]) token_part();
}

// print-plate preview: the bear's layout from tools/make_3mf.py (which writes the real
// plate 3MF), with the board along the front edge and two rows of parts behind it. The
// bunny's taller board does not leave room for the rows, so make_3mf.py packs its real
// plate around the ears instead (see out/bunny/token_board_plate.3mf).
module plate() {
    gap = 5;
    color(c_board) board_part();
    // row 1: five tokens
    for (i = [0 : 4]) color(c_token) translate([(i - 2) * (token_d + gap), -gap - token_d / 2, 0])
        token_part();
    // row 2: two tokens, the honey pot and the two feet
    y2 = -2 * gap - token_d;
    w = [token_d, token_d, 2 * (pot_ro + band_out), 2 * foot_hw, 2 * foot_hw];
    x0 = -(w[0] + w[1] + w[2] + w[3] + w[4] + 4 * gap) / 2;
    function xc(i) = x0 + (i == 0 ? 0 : w[0] + gap) + (i > 1 ? w[1] + gap : 0)
                   + (i > 2 ? w[2] + gap : 0) + (i > 3 ? w[3] + gap : 0) + w[i] / 2;
    for (i = [0 : 1]) color(c_token) translate([xc(i), y2 - token_d / 2, 0]) token_part();
    color(c_pot) translate([xc(2), y2 - w[2] / 2, 0]) pot_part();
    for (i = [3 : 4]) color(c_board) translate([xc(i), y2 - (edge_t + lip_t + 9), 0]) foot_part();
}

if (part == "board") board_part();
else if (part == "foot") foot_part();
else if (part == "pot") pot_part();
else if (part == "token") token_part();
else if (part == "assembly") assembly();
else if (part == "plate") plate();
