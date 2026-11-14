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
//    "axle"     - axle rod with button ends (prints standing up)
//    "hub"      - spoked hub that fills the cardboard core (prints standing up)
//    "assembly" - everything in place, with a dummy sticker roll (preview only)
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
core_clr       = 0.4;  // radial gap between hub and cardboard core
axle_clr       = 0.4;  // clearance of axle journals in the cheek slots, and of hub on axle
snap_interf    = 0.5;  // how far the snap bump narrows the axle slot
roll_gap_min   = 4.0;  // gap between the biggest roll and base / deck wall

// ---------------------------------------------------------------------
// 3. DISPENSER GEOMETRY
// ---------------------------------------------------------------------
base_h         = 12.0;   // base slab thickness (chunky = stable, "weighted" look)
base_w         = 92.0;   // base width (along X)
base_back      = 14.0;   // base extends this far behind the bear head
base_front     = 18.0;   // base extends this far in front of the peel edge
base_corner_r  = 18.0;   // footprint corner radius
base_top_fillet= 3.0;    // rounded top edge of the base

cheek_t        = 6.0;    // thickness of each side cheek
head_margin    = 8.0;    // bear head radius = roll_od_max/2 + head_margin
ear_r          = 13.0;
ear_angle      = 36;     // degrees from vertical
ear_dist_extra = -2.0;   // ear centre distance = head radius + this

deck_len       = 34.0;   // length of the flat peel deck (stickers ride on it)
wall_t         = 6.0;    // wall that holds the deck up, in front of the roll
peel_angle     = 45;     // interior angle of the peel edge (deg). Smaller = sharper peel.
                         // 40-50 prints well without supports.
rail_h         = 2.0;    // cheek walls stand this high above the deck at the front
keeper_gap     = 2.6;    // liner slot height under the keeper bar on the deck
keeper_t       = 3.0;    // keeper bar thickness
keeper_w       = 4.0;    // keeper bar depth (along Y)

guide_bar_w    = 6.0;    // lower guide bar the liner wraps under (Y size)
guide_bar_h    = 6.0;    // (Z size)
guide_bar_gap  = 6.0;    // gap between base top and guide bar (liner exit tunnel)
guide_bar_back = 7.0;    // guide bar rear face is this far in front of the deck wall

// Axle
journal_d      = 10.0;   // part of the axle that sits in the cheek slots
axle_mid_d     = 14.0;   // middle section (inside the hub) and button ends
button_h       = 4.0;    // button ends outside the cheeks
journal_play   = 0.6;    // axial play

// Hub (fills the cardboard core)
hub_len        = roll_width - 1.0;
hub_wall       = 2.0;
hub_spokes     = 5;
hub_spoke_t    = 2.4;

// Weight pockets & feet (underside)
coin_d         = 24.8;   // fits a US quarter (24.26) / 1 EUR (23.25) / 20mm steel washers
coin_depth     = 6.0;    // 3 quarters per pocket
foot_d         = 10.5;   // stick-on silicone bumper feet
foot_depth     = 1.0;

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
hub_od     = core_id - 2 * core_clr;
hub_bore   = axle_mid_d + 2 * axle_clr;
bar_y0     = wall_y1 + guide_bar_back;
bar_z0     = base_h + guide_bar_gap;
keeper_y0  = wall_y0 + 4;

echo(str("axle height = ", axle_z, " mm, peel edge at y = ", edge_y,
         ", deck height = ", deck_z, ", guide wedge bottom z = ", v_z));
echo(str("cheek gap = ", gap, ", slot width = ", slot_w, ", hub OD = ", hub_od,
         ", hub bore = ", hub_bore));
// Machine-readable dimensions for tools/build_viewer.py (keeps the animation in sync with the CAD)
echo(VIEWER_PARAMS = [
    ["gap", gap], ["cheek_t", cheek_t], ["axle_z", axle_z], ["deck_z", deck_z],
    ["wall_y0", wall_y0], ["wall_y1", wall_y1], ["edge_y", edge_y], ["v_z", v_z],
    ["bar_y0", bar_y0], ["bar_z0", bar_z0], ["guide_bar_w", guide_bar_w], ["guide_bar_h", guide_bar_h],
    ["keeper_y0", keeper_y0], ["keeper_gap", keeper_gap], ["base_h", base_h],
    ["base_y0", base_y0], ["base_y1", base_y1], ["base_w", base_w],
    ["roll_width", roll_width], ["roll_od", roll_od], ["core_id", core_id], ["core_wall", core_wall],
    ["sticker_d", sticker_d], ["journal_play", journal_play], ["button_h", button_h],
    ["hub_len", hub_len], ["roll_od_max", roll_od_max]]);
assert(v_z >= bar_z0 + guide_bar_h + 3, "peel wedge collides with lower guide bar: increase deck height or peel_angle");
assert(hub_od > hub_bore + 4, "core too small for this axle");

// =====================================================================
// HELPERS
// =====================================================================
// Map a 2D profile drawn in (Y, Z) onto the YZ plane and extrude it along +X.
module yz_extrude(h) { rotate([90, 0, 90]) linear_extrude(h) children(); }

module rounded_rect2d(w, l, r) {        // centred on X, Y from 0..l
    hull() for (sx = [-1, 1], y = [r, l - r])
        translate([sx * (w / 2 - r), y]) circle(r);
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

module base_underside_cuts() {
    // weight pockets (open to the bed -> no supports)
    for (sx = [-1, 1], y = [-head_r + 22, edge_y - 18])
        translate([sx * 27, y, -0.01]) cylinder(d = coin_d, h = coin_depth + 0.01);
    // bumper feet recesses
    for (sx = [-1, 1], y = [base_y0 + 14, base_y1 - 14])
        translate([sx * (base_w / 2 - 14), y, -0.01]) cylinder(d = foot_d, h = foot_depth + 0.01);
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
module cheek_outline2d() {
    // head + forward body that runs down to rail height at the peel edge
    hull() {
        translate([0, axle_z]) circle(head_r, $fn = 120);
        translate([-head_r + 6, base_h - 1]) square([edge_y + head_r - 6 - 4, 1]);
        translate([edge_y - 4, deck_z + rail_h - 4]) circle(4);
        translate([edge_y - 4, base_h - 1]) square([4, 1]);
    }
    // ears
    for (s = [-1, 1])
        translate([0, axle_z] + (head_r + ear_dist_extra) * [s * sin(ear_angle), cos(ear_angle)])
            circle(ear_r);
    // smooth the ear-to-head junctions so the overhang under each ear is gentle
    for (s = [-1, 1]) hull() {
        translate([0, axle_z] + (head_r + ear_dist_extra) * [s * sin(ear_angle), cos(ear_angle)])
            circle(ear_r * 0.55);
        translate([0, axle_z] + (head_r - 10) * [s * sin(ear_angle + 14), cos(ear_angle + 14)])
            circle(6);
    }
}

// U-slot for the axle journal, with a flexible snap tine on its front side
tine_t     = 2.4;
relief_w   = 1.2;
tine_free  = 3.0;   // tine's free end sits this far above the axle centre
tine_len   = 16.0;
module axle_slot2d() {
    top = axle_z + head_r + ear_r + 5;
    translate([0, axle_z]) circle(d = slot_w);
    translate([-slot_w / 2, axle_z]) square([slot_w, top - axle_z]);
    // flared entry at the top of the head
    translate([0, axle_z + head_r]) polygon([[-slot_w / 2 - 2.5, 0.5], [slot_w / 2 + 2.5, 0.5],
                                             [slot_w / 2, -3], [-slot_w / 2, -3]]);
    // snap-tine relief (vertical slit + horizontal slit freeing the tine's lower end)
    translate([slot_w / 2 + tine_t, axle_z + tine_free - relief_w])
        square([relief_w, tine_len + relief_w]);
    translate([slot_w / 2 - 0.1, axle_z + tine_free - relief_w])
        square([tine_t + relief_w + 0.1, relief_w]);
}
module snap_bump2d() {
    zb = axle_z + journal_d / 2 + 1.6;
    polygon([[slot_w / 2 + 0.05, zb - 1.6], [slot_w / 2 - snap_interf, zb - 0.2],
             [slot_w / 2 - snap_interf, zb + 0.2], [slot_w / 2 + 0.05, zb + 2.4]]);
}

module bear_face2d() {
    // eyes, cheeks (blush), smile - centred on the axle "nose"
    for (s = [-1, 1]) translate([s * 15, axle_z + 13]) scale([1, 1.25]) circle(4.2);
    for (s = [-1, 1]) translate([s * 26, axle_z - 6]) scale([1.3, 1]) circle(4.5);
    translate([0, axle_z]) difference() {
        intersection() {
            circle(17);
            translate([-30, -40]) square([60, 32]);
        }
        circle(14.4);
    }
    // inner ears
    for (s = [-1, 1])
        translate([0, axle_z] + (head_r + ear_dist_extra) * [s * sin(ear_angle), cos(ear_angle)])
            circle(ear_r - 5.5);
}

module cheek_shape2d() {
    difference() {
        cheek_outline2d();
        difference() { axle_slot2d(); snap_bump2d(); }
    }
}

// Right-hand cheek (+X). The outer edges get a stepped 45-degree chamfer
// (cheek_chamfer deep) so the bear heads look soft rather than slab-cut.
cheek_chamfer = 1.2;
module cheek_right() {
    steps = 3;
    st = cheek_chamfer / steps;
    difference() {
        translate([gap / 2, 0, 0]) {
            yz_extrude(cheek_t - cheek_chamfer) cheek_shape2d();
            for (i = [1 : steps])
                translate([cheek_t - cheek_chamfer + (i - 1) * st, 0, 0])
                    yz_extrude(st) offset(delta = -st * i) cheek_shape2d();
        }
        // debossed bear face on the outside
        translate([gap / 2 + cheek_t - face_depth, 0, 0])
            yz_extrude(face_depth + 0.01) difference() { bear_face2d(); axle_slot2d(); }
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
module guide_bar_profile2d() {
    c = 1.6;
    translate([bar_y0, bar_z0]) polygon([[c, 0], [guide_bar_w - c, 0], [guide_bar_w, c],
        [guide_bar_w, guide_bar_h], [0, guide_bar_h], [0, c]]);
}
module deck_parts() {
    span = gap + 2;   // overlap 1 mm into each cheek
    translate([-span / 2, 0, 0]) yz_extrude(span) {
        deck_profile2d();
        guide_bar_profile2d();
        translate([keeper_y0, deck_z + keeper_gap]) square([keeper_w, keeper_t]);
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
        base_underside_cuts();
        base_top_decor();
    }
}

// =====================================================================
// AXLE  (modelled standing up: bottom button on the bed)
// =====================================================================
journal_len = cheek_t + journal_play;
mid_len     = gap - journal_play;
cone_h      = (axle_mid_d - journal_d) / 2;    // 45-degree transitions
axle_total  = 2 * button_h + 2 * journal_len + mid_len;

module axle_part() {
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

// =====================================================================
// HUB  (spoked tube that fills the core; roll + hub spin on the axle)
// =====================================================================
module hub_part() {
    ch = 0.8;
    difference() {
        union() {
            // outer ring with chamfered ends for easy insertion into the core
            rotate_extrude($fn = 120) polygon([
                [hub_od / 2 - hub_wall, 0], [hub_od / 2 - ch, 0], [hub_od / 2, ch],
                [hub_od / 2, hub_len - ch], [hub_od / 2 - ch, hub_len],
                [hub_od / 2 - hub_wall, hub_len]]);
            // inner ring
            cylinder(d = hub_bore + 2 * hub_wall + 1, h = hub_len);
            // spokes
            for (i = [0 : hub_spokes - 1]) rotate(i * 360 / hub_spokes)
                translate([0, -hub_spoke_t / 2, 0])
                    cube([hub_od / 2 - hub_wall / 2, hub_spoke_t, hub_len]);
        }
        translate([0, 0, -1]) cylinder(d = hub_bore, h = hub_len + 2);
        // chamfer the bore ends
        translate([0, 0, -0.01]) cylinder(d1 = hub_bore + 1.6, d2 = hub_bore - 0.01, h = 0.81);
        translate([0, 0, hub_len - 0.8]) cylinder(d1 = hub_bore - 0.01, d2 = hub_bore + 1.6, h = 0.81);
    }
}

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
if (part == "base") {
    base_part();
} else if (part == "axle") {
    axle_part();
} else if (part == "hub") {
    hub_part();
} else if (part == "assembly") {
    color("#ffb6c8") base_part();
    // axle lies along X, centred, bottom button on the -X side
    color("#7ec8e3") translate([-(gap / 2 + cheek_t + journal_play / 2 + button_h), 0, axle_z])
        rotate([0, 90, 0]) axle_part();
    color("#ffd166") translate([-hub_len / 2, 0, axle_z]) rotate([0, 90, 0]) hub_part();
    preview_roll();
} else if (part == "plate") {
    // all three parts in their print orientation (preview of the build plate)
    color("#ffb6c8") base_part();
    color("#7ec8e3") translate([base_w / 2 + 22, 20, 0]) axle_part();
    color("#ffd166") translate([base_w / 2 + 30, -40, 0]) hub_part();
}
