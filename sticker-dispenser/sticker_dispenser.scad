// =====================================================================
//  Sticker-roll dispenser  ("Bear Buddy")
//  Parametric OpenSCAD model. All units in millimetres.
//
//  Coordinate system:  X = along the axle (roll width direction)
//                      Y = forward (towards the peel edge / the child)
//                      Z = up
//
//  Printable parts (select with -D 'part="..."'):
//    "base"     - base + bear-head side cheeks + peel deck + guide bars (one piece)
//    "axle"     - spool axle: button ends, journals for the cheek slots, and fins that
//                 fill the cardboard core (one piece, prints standing up)
//    "assembly" - everything in place, with a dummy sticker roll (preview only)
//    "plate"    - both parts in print orientation (preview only)
// =====================================================================

part = "assembly";

// ---------------------------------------------------------------------
// 1. MEASURED ROLL DIMENSIONS  (photo estimates -> re-measure with calipers!)
//    See DIMENSIONS.md for how these were estimated and their uncertainty.
// ---------------------------------------------------------------------
roll_width   = 33.0;   // width of the liner / roll, measured across the roll   (+/-1.5)
roll_od      = 50.0;   // outer diameter of the roll in the photos              (+/-4)
core_id      = 37.5;   // inner diameter of the cardboard core                  (+/-1)
core_wall    = 1.5;    // cardboard core wall thickness (only used for the preview roll)
sticker_d    = 30.0;   // sticker diameter (preview only)

// Largest roll the dispenser must hold (a fresh, full roll is bigger than the
// part-used one in the photos). Sets axle height and bear-head size.
roll_od_max  = 80.0;

// ---------------------------------------------------------------------
// 2. CLEARANCES
// ---------------------------------------------------------------------
side_clearance = 2.0;  // total extra width between the cheeks (roll_width + 2)
core_clr       = 0.4;  // radial gap between the axle fins and the cardboard core
axle_clr       = 0.4;  // clearance of the axle journals in the cheek slots
snap_interf    = 0.5;  // how far the snap bump narrows the axle slot
roll_gap_min   = 4.0;  // gap between the biggest roll and base / deck wall

// ---------------------------------------------------------------------
// 3. DISPENSER GEOMETRY
// ---------------------------------------------------------------------
base_h         = 10.0;   // base slab thickness (chunky = stable, "weighted" look)
base_w         = 84.0;   // base width (along X)
base_back      = 6.0;    // base extends this far behind the bear head
base_front     = 18.0;   // base extends this far in front of the peel edge
base_corner_r  = 18.0;   // footprint corner radius
base_top_fillet= 3.0;    // rounded top edge of the base

cheek_t        = 5.0;    // thickness of each side cheek
head_margin    = 6.0;    // bear head radius = roll_od_max/2 + head_margin
ear_r          = 13.0;
ear_angle      = 42;     // degrees from vertical
ear_dist_extra = -2.0;   // ear centre distance = head radius + this

deck_len       = 34.0;   // length of the flat peel deck (stickers ride on it)
wall_t         = 6.0;    // wall that holds the deck up, in front of the roll
peel_angle     = 45;     // interior angle of the peel edge (deg). Smaller = sharper peel.
                         // 40-50 prints well without supports.
rail_h         = 2.0;    // cheek walls stand this high above the deck at the front
keeper_gap     = 2.6;    // liner slot height under the keeper bar on the deck
keeper_t       = 1.6;    // keeper bar thickness above its V underside
keeper_w       = 4.0;    // keeper bar depth (along Y)

guide_bar_w    = 6.0;    // lower guide bar the liner wraps under (Y size)
guide_bar_h    = 6.0;    // (Z size)
guide_bar_gap  = 6.0;    // gap between base top and guide bar (liner exit tunnel)
guide_bar_back = 7.0;    // guide bar rear face is this far in front of the deck wall

// Spool axle. The axle and the roll turn together; the journals turn in the cheek slots.
journal_d      = 10.0;   // part of the axle that sits in the cheek slots
axle_mid_d     = 14.0;   // middle section and button ends (buttons keep it from sliding out)
button_h       = 4.0;    // button ends outside the cheeks
journal_play   = 0.6;    // axial play
fin_count      = 6;      // radial fins that fill the cardboard core
fin_t          = 1.6;    // fin thickness (4 extrusion lines)

// Weight bay & feet
// The weights go in an open-top bay in the base, between the cheeks and hidden under
// the roll. (A pocket on the underside needs a ceiling; a support-free 45-degree
// ceiling over a 25 mm coin needs 12.4 mm of height on top of the coins, more than
// the base has.) Glue the weights in.
bay_w          = 31.0;   // across X (fits between the cheeks); a US quarter is 24.3 mm
bay_l          = 78.0;   // along Y: three stacks of quarters / 1-euro coins
bay_depth      = 6.0;    // 3 quarters per stack (5.3 mm)
bay_r          = 5.0;
foot_d         = 10.5;   // stick-on silicone bumper feet (underside recesses)
foot_depth     = 1.0;    // recess depth; a 45-degree cone above it keeps the ceiling support-free

face_depth     = 1.0;    // depth of the debossed bear face on the cheeks

$fn = 72;

// ---------------------------------------------------------------------
// DERIVED VALUES (don't edit)
// ---------------------------------------------------------------------
gap        = roll_width + side_clearance;          // inner distance between cheeks
roll_r_max = roll_od_max / 2;
axle_z     = base_h + roll_r_max + roll_gap_min;   // axle height
head_r     = roll_r_max + head_margin;
deck_z     = axle_z;                               // deck top height
wall_y0    = roll_r_max + roll_gap_min;            // rear face of the deck wall
wall_y1    = wall_y0 + wall_t;
edge_y     = wall_y0 + deck_len;                   // peel edge position
v_z        = deck_z - (edge_y - wall_y1) * tan(peel_angle);  // bottom of peel wedge
base_y0    = -head_r - base_back;
base_y1    = edge_y + base_front;
slot_w     = journal_d + axle_clr;
fin_od     = core_id - 2 * core_clr;                 // diameter across the fin tips
bar_y0     = wall_y1 + guide_bar_back;
bar_z0     = base_h + guide_bar_gap;
keeper_y0  = wall_y0 + 4;
bay_y      = (-head_r + wall_y0) / 2 + 2;              // bay centre (between head back and deck wall)

echo(str("axle height = ", axle_z, " mm, peel edge at y = ", edge_y,
         ", deck height = ", deck_z, ", guide wedge bottom z = ", v_z));
echo(str("cheek gap = ", gap, ", slot width = ", slot_w, ", fin OD = ", fin_od));
// Machine-readable dimensions for tools/build_viewer.py (keeps the animation in sync with the CAD)
echo(VIEWER_PARAMS = [
    ["gap", gap], ["cheek_t", cheek_t], ["axle_z", axle_z], ["deck_z", deck_z],
    ["wall_y0", wall_y0], ["wall_y1", wall_y1], ["edge_y", edge_y], ["v_z", v_z],
    ["bar_y0", bar_y0], ["bar_z0", bar_z0], ["guide_bar_w", guide_bar_w], ["guide_bar_h", guide_bar_h],
    ["keeper_y0", keeper_y0], ["keeper_gap", keeper_gap], ["base_h", base_h],
    ["base_y0", base_y0], ["base_y1", base_y1], ["base_w", base_w],
    ["roll_width", roll_width], ["roll_od", roll_od], ["core_id", core_id], ["core_wall", core_wall],
    ["sticker_d", sticker_d], ["journal_play", journal_play], ["button_h", button_h],
    ["roll_od_max", roll_od_max], ["fin_od", fin_od]]);
assert(v_z >= bar_z0 + guide_bar_h + 3, "peel wedge collides with lower guide bar: increase deck height or peel_angle");
assert(fin_od > axle_mid_d + 6, "core too small for this axle");
assert(bay_w <= gap - 3 && bay_y + bay_l / 2 < wall_y0 - 2, "weight bay does not fit between the cheeks");

// =====================================================================
// HELPERS
// =====================================================================
// Map a 2D profile drawn in (Y, Z) onto the YZ plane and extrude it along +X.
module yz_extrude(h) { rotate([90, 0, 90]) linear_extrude(h) children(); }

module rounded_rect2d_c(w, l, r) {      // centred on the origin
    hull() for (sx = [-1, 1], sy = [-1, 1])
        translate([sx * (w / 2 - r), sy * (l / 2 - r)]) circle(r);
}

// A rounded "puck": vertical cylinder with a filleted top edge
module puck(r, h, f) {
    rotate_extrude($fn = 64) hull() {
        square([0.01, h]);
        square([r, h - f]);
        translate([r - f, h - f]) circle(f, $fn = 24);
        square([r - 0.6, 0.01]);       // tiny bottom chamfer vs elephant foot
        translate([0, 0.6]) square([r, 0.01]);
    }
}

// =====================================================================
// BASE
// =====================================================================
module base_slab() {
    l = base_y1 - base_y0;
    translate([0, base_y0, 0])
    hull() for (sx = [-1, 1], y = [base_corner_r, l - base_corner_r])
        translate([sx * (base_w / 2 - base_corner_r), y, 0])
            puck(base_corner_r, base_h, base_top_fillet);
}

module base_cuts() {
    // weight bay, open at the top, centred under the roll
    translate([0, bay_y, base_h - bay_depth]) linear_extrude(bay_depth + 1)
        rounded_rect2d_c(bay_w, bay_l, bay_r);
    // bumper-feet recesses with a 45-degree cone ceiling
    for (sx = [-1, 1], y = [base_y0 + 14, base_y1 - 14])
        translate([sx * (base_w / 2 - 14), y, 0]) {
            translate([0, 0, -0.01]) cylinder(d = foot_d, h = foot_depth + 0.01);
            translate([0, 0, foot_depth]) cylinder(d1 = foot_d, d2 = 0.1, h = foot_d / 2);
        }
}

// little debossed stars on the base top, either side of the liner exit
module star2d(r = 6, n = 5) {
    polygon([for (i = [0 : 2 * n - 1])
        let(a = 90 + i * 180 / n, rr = (i % 2 == 0) ? r : r * 0.45) [rr * cos(a), rr * sin(a)]]);
}
module base_top_decor() {
    for (sx = [-1, 1])
        translate([sx * 33, edge_y + 6, base_h - 0.8]) linear_extrude(2) offset(r = 0.6) star2d(5.5);
    translate([0, base_y0 + 8, base_h - 0.8]) linear_extrude(2)
        for (sx = [-1, 1]) translate([sx * 10, 0]) offset(r = 0.5) star2d(3.5);
}

// =====================================================================
// CHEEKS (bear heads)
// =====================================================================
// The cheek outline is built from convex pieces so each can get a true 45-degree
// chamfer (hull of the full slab and an inset top layer). A stepped chamfer leaves
// 0.4 mm horizontal ledges that Bambu's tree supports reach for.
ear_c = function(s) [0, axle_z] + (head_r + ear_dist_extra) * [s * sin(ear_angle), cos(ear_angle)];
module cheek_piece2d(i) {
    if (i == 0) hull() {     // head + forward body that runs down to rail height at the peel edge
        translate([0, axle_z]) circle(head_r, $fn = 120);
        translate([-head_r + 6, base_h - 1]) square([edge_y + head_r - 6 - 4, 1]);
        translate([edge_y - 4, deck_z + rail_h - 4]) circle(4);
        translate([edge_y - 4, base_h - 1]) square([4, 1]);
    }
    if (i == 1 || i == 2) translate(ear_c(i == 1 ? -1 : 1)) circle(ear_r);   // ears
    if (i == 3 || i == 4) let(s = i == 3 ? -1 : 1) hull() {   // smooth ear-to-head junctions
        translate(ear_c(s)) circle(ear_r * 0.55);
        translate([0, axle_z] + (head_r - 10) * [s * sin(ear_angle + 14), cos(ear_angle + 14)])
            circle(6);
    }
}
module cheek_outline2d() { for (i = [0 : 4]) cheek_piece2d(i); }

// U-slot for the axle journal, with a flexible snap tine on its front side.
// The tine grows UP from a root below the axle seat (a tine hanging from above would
// start printing as a floating island that needs support). The snap bump sits near its
// free top end; a 45-degree slit sloping down-outward frees that end, so every
// ceiling is at 45 degrees and the material above the slit is connected below it.
tine_t     = 2.4;
relief_w   = 1.2;
tine_top   = 10.0;  // tine's free top end (at the slot edge) sits this far above the axle centre
tine_len   = 20.0;  // root to free end; ~8 N to click the axle past snap_interf = 0.5
module axle_slot2d() {
    top = axle_z + head_r + ear_r + 5;
    translate([0, axle_z]) circle(d = slot_w);
    translate([-slot_w / 2, axle_z]) square([slot_w, top - axle_z]);
    // flared entry at the top of the head
    translate([0, axle_z + head_r]) polygon([[-slot_w / 2 - 2.5, 0.5], [slot_w / 2 + 2.5, 0.5],
                                             [slot_w / 2, -3], [-slot_w / 2, -3]]);
    s    = slot_w / 2;
    ztt  = axle_z + tine_top;                // tine top at the slot edge (its highest point)
    dv   = relief_w * sqrt(2);               // vertical thickness of the 45-degree slit
    run  = tine_t + relief_w + 0.5;
    polygon([[s + tine_t, ztt - tine_len], [s + tine_t + relief_w, ztt - tine_len],   // relief slit floor
             [s + tine_t + relief_w, ztt + dv - run],                                 // up its outer wall
             [s - 0.5, ztt + dv],                                                     // 45-degree ceiling
             [s - 0.5, ztt],                                                          // into the slot
             [s + tine_t, ztt - tine_t - 0.5]]);                                      // 45-degree tine top
}
module snap_bump2d() {
    zb = axle_z + journal_d / 2 + 1.6;
    polygon([[slot_w / 2 + 0.05, zb - 1.6], [slot_w / 2 - snap_interf, zb - 0.2],
             [slot_w / 2 - snap_interf, zb + 0.2], [slot_w / 2 + 0.05, zb + 2.4]]);
}

// Bear face, as a list of convex pieces (eyes, blush, inner ears, and the smile as a
// chain of short segments) so each can be debossed with a 45-degree ceiling.
smile_r = 15.7;
smile_w = 2.6;
smile_a = [for (a = [212 : 8 : 328]) a];
module bear_face_piece2d(i) {
    if (i < 2) translate([(i == 0 ? -1 : 1) * 15, axle_z + 13]) scale([1, 1.25]) circle(4.2);   // eyes
    else if (i < 4) translate([(i == 2 ? -1 : 1) * 26, axle_z - 6]) scale([1.3, 1]) circle(4.5);  // blush
    else if (i < 6) translate(ear_c(i == 4 ? -1 : 1)) circle(ear_r - 5.5);                         // inner ears
    else let(k = i - 6) hull() for (a = [smile_a[k], smile_a[k + 1]])                            // smile
        translate([0, axle_z] + smile_r * [cos(a), sin(a)]) circle(d = smile_w, $fn = 24);
}
face_pieces = 6 + len(smile_a) - 1;

// Deboss one face piece into the outer face at x = x_out (recess goes towards -X). The
// recess outline slides down by its depth as it goes in, so its ceiling is at 45 degrees.
module face_deboss(x_out) {
    for (i = [0 : face_pieces - 1]) hull() {
        translate([x_out, 0, 0]) yz_extrude(0.5) bear_face_piece2d(i);   // starts exactly on the face
        translate([x_out - face_depth, 0, -face_depth]) yz_extrude(0.02) bear_face_piece2d(i);
    }
}

// Right-hand cheek (+X). The outer edges get a true 45-degree chamfer
// (cheek_chamfer deep) so the bear heads look soft rather than slab-cut.
cheek_chamfer = 1.2;
module chamfered_piece(i) {
    hull() {
        yz_extrude(cheek_t - cheek_chamfer) cheek_piece2d(i);
        translate([cheek_t - cheek_chamfer, 0, 0])
            yz_extrude(cheek_chamfer) offset(delta = -cheek_chamfer) cheek_piece2d(i);
    }
}
module cheek_right() {
    difference() {
        translate([gap / 2, 0, 0]) difference() {
            for (i = [0 : 4]) chamfered_piece(i);
            translate([-1, 0, 0]) yz_extrude(cheek_t + 2) difference() { axle_slot2d(); snap_bump2d(); }
        }
        // debossed bear face on the outside
        face_deboss(gap / 2 + cheek_t);
    }
}

module cheek(side) {   // side = -1 (left, -X) or +1 (right, +X)
    if (side > 0) cheek_right(); else mirror([1, 0, 0]) cheek_right();
}

// =====================================================================
// PEEL DECK, KEEPER BAR, LOWER GUIDE BAR
// =====================================================================
module deck_profile2d() {
    r = 3;  // rounded rear-top corner where the liner comes on
    polygon(concat(
        [[wall_y0, base_h - 0.5]],
        [for (a = [180 : -10 : 90]) [wall_y0 + r + r * cos(a), deck_z - r + r * sin(a)]],
        [[edge_y, deck_z], [wall_y1, v_z], [wall_y1, base_h - 0.5]]
    ));
}
// The two bars span the 35 mm gap between the cheeks. A flat underside would be a
// long bridge that Bambu's tree supports fill in; a 45-degree V underside needs none.
// The liner wraps around the rear face and under the V of the lower guide bar.
module guide_bar_profile2d() {
    v = guide_bar_w / 2;
    translate([bar_y0, bar_z0]) polygon([[v, 0], [guide_bar_w, v],
        [guide_bar_w, guide_bar_h], [0, guide_bar_h], [0, v]]);
}
module keeper_bar_profile2d() {     // liner slides under its V point on the deck
    v = keeper_w / 2;
    translate([keeper_y0, deck_z + keeper_gap]) polygon([[v, 0], [keeper_w, v],
        [keeper_w, v + keeper_t], [0, v + keeper_t], [0, v]]);
}
module deck_parts() {
    span = gap + 2;   // overlap 1 mm into each cheek
    translate([-span / 2, 0, 0]) yz_extrude(span) {
        deck_profile2d();
        guide_bar_profile2d();
        keeper_bar_profile2d();
    }
}

module base_part() {
    difference() {
        union() {
            base_slab();
            cheek(-1);
            cheek(1);
            deck_parts();
        }
        base_cuts();
        base_top_decor();
    }
}

// =====================================================================
// SPOOL AXLE  (modelled standing up: bottom button on the bed)
// =====================================================================
journal_len = cheek_t + journal_play;
mid_len     = gap - journal_play;
cone_h      = (axle_mid_d - journal_d) / 2;    // 45-degree transitions
axle_total  = 2 * button_h + 2 * journal_len + mid_len;
fin_z0      = button_h + journal_len + 0.5;          // fins stop short of the cheek faces
fin_z1      = button_h + journal_len + mid_len - 1.0;

module axle_rod() {
    rotate_extrude($fn = 64) polygon(concat(
        [[0, 0], [axle_mid_d / 2 - 0.6, 0], [axle_mid_d / 2, 0.6],          // bottom button
         [axle_mid_d / 2, button_h], [journal_d / 2, button_h],
         [journal_d / 2, button_h + journal_len],                         // lower journal
         [axle_mid_d / 2, button_h + journal_len + cone_h],                // 45 deg up
         [axle_mid_d / 2, button_h + journal_len + mid_len - cone_h],
         [journal_d / 2, button_h + journal_len + mid_len],               // 45 deg in
         [journal_d / 2, button_h + 2 * journal_len + mid_len],           // upper journal
         [axle_mid_d / 2, button_h + 2 * journal_len + mid_len + cone_h]], // 45 deg button underside
        [for (a = [0 : 10 : 90])                                          // domed top
            [axle_mid_d / 2 * cos(a),
             axle_total - (button_h - cone_h) + (button_h - cone_h) * sin(a)]],
        [[0, axle_total]]
    ));
}

// Radial fins fill the cardboard core (tips at fin_od). Their lower ends rise at
// 45 degrees from the rod so they print without support; the top ends are chamfered
// so the core slides on easily. This replaces the separate spoked hub of v1.
module axle_fins() {
    r_in = journal_d / 2 - 0.4;
    R = fin_od / 2;
    for (i = [0 : fin_count - 1]) rotate(i * 360 / fin_count)
        rotate([90, 0, 0]) translate([0, 0, -fin_t / 2]) linear_extrude(fin_t)
            polygon([[r_in, fin_z0], [R, fin_z0 + (R - r_in)], [R, fin_z1 - 0.8],
                     [R - 0.8, fin_z1], [r_in, fin_z1]]);
}

module axle_part() { axle_rod(); axle_fins(); }

// =====================================================================
// PREVIEW ROLL (not printed)
// =====================================================================
module preview_roll() {
    translate([-roll_width / 2, 0, axle_z]) rotate([0, 90, 0]) {
        color("BurlyWood") difference() {
            cylinder(d = core_id + 2 * core_wall, h = roll_width);
            translate([0, 0, -1]) cylinder(d = core_id, h = roll_width + 2);
        }
        color("WhiteSmoke") difference() {
            cylinder(d = roll_od, h = roll_width);
            translate([0, 0, -1]) cylinder(d = core_id + 2 * core_wall, h = roll_width + 2);
        }
    }
}

// =====================================================================
// PART SELECTION
// =====================================================================
base_color = "#5bb8f0";   // sky blue
axle_color = "#ffc93c";   // sunshine yellow
if (part == "base") {
    base_part();
} else if (part == "axle") {
    axle_part();
} else if (part == "assembly") {
    color(base_color) base_part();
    // axle lies along X, centred, bottom button on the -X side
    color(axle_color) translate([-(gap / 2 + cheek_t + journal_play / 2 + button_h), 0, axle_z])
        rotate([0, 90, 0]) axle_part();
    preview_roll();
} else if (part == "plate") {
    // both parts in their print orientation (preview of the build plate)
    color(base_color) base_part();
    color(axle_color) translate([base_w / 2 + 30, 10, 0]) axle_part();
}
