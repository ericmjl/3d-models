// =====================================================================
//  Single-brush wall holder with a cat or bunny back plate.
//  Parametric OpenSCAD model. All units in millimetres.
//
//  Prints flat on its back (the wall face is on the bed). The neck slides
//  down a channel, the wider head rests on two shoulders, and 45 degree
//  lips keep the handle from falling forward. The channel is open at the
//  front and at the bottom.
//
//  Two colours, both PLA, for an X1 Carbon with AMS:
//      part = "white"   the body, including the cradle
//      part = "black"   outline and face, the top 0.8 mm of the plate
//  The black mesh sits in a recess in the white plate, just clear of the
//  white so the two meshes do not overlap. Nothing black is taller than
//  the plate, and nothing overhangs past 45 degrees, so the pair needs
//  no supports.
//
//  Coordinates (also the print orientation):
//      X = along the wall     Y = up the wall     Z = out from the wall
//  Z = 0 is the back face, on the bed.
//
//  theme = "cat"   paddle brush (brush A)
//  theme = "bunny" pink detangling brush (brush B)
//  Pass either on the command line:
//      openscad -D 'theme="bunny"' -D 'part="white"' -o white.stl hairbrush_holder.scad
//
//  Brush numbers are ruler estimates. clr_side / clr_t add the clearance.
//  Edit a number in the theme block, or override it with -D.
// =====================================================================

/* [Preview] */
theme = "cat";   // [cat, bunny]
part  = "assembly"; // [white, black, preview, assembly]

/* [Brush A, paddle, cat] */
cat_overall_l = 250;
cat_head_w    = 95;
cat_head_l    = 135;
cat_head_t    = 35;   // including bristles
cat_head_base = 20;   // cushion, without the bristle length
cat_neck_w    = 25;   // just under the head
cat_neck_t    = 20;   // ASSUMED: not measured; using the grip thickness
cat_grip_w    = 30;
cat_grip_t    = 20;   // estimated

/* [Brush B, pink, bunny] */
bun_overall_l = 240;
bun_head_w    = 75;
bun_head_l    = 120;
bun_head_t    = 30;   // including bristles, estimated
bun_head_base = 16;   // ASSUMED cushion thickness
bun_neck_w    = 30;
bun_neck_t    = 15;   // ASSUMED: not measured; using the grip thickness
bun_grip_w    = 32;
bun_grip_t    = 15;   // estimated

/* [Clearance and cradle] */
clr_side   = 1.5;  // extra channel width, each side of the neck
clr_t      = 1.5;  // extra depth in front of the neck
lip_in_pad = 4.0;  // lip reach past clr_side. Underside stays 45 deg.
wall_t     = 4.8;
back_t     = 4.6;  // white plate. Room for a countersink under the colour.
color_h    = 0.8;  // black inlay, four 0.20 mm layers
color_gap  = 0.02; // black sits just inside the recess, so the two meshes do not overlap
bottom_m   = 30;
retain_h   = 32;   // neck captured behind the lips
entry_h    = 24;   // open mouth above the lips
lip_tip    = 1.8;
top_taper  = 6;
bottom_taper = 5;
shoulder_chamfer = 1.0;

/* [Mounting] */
mount       = "both"; // [screws, strip, both]
screw_d     = 4.5;    // M4 or #8 clearance
screw_csk_d = 8.8;    // 90 deg included, opens upward
screw_inset = 14;
strip_w     = 19;     // medium Command picture-hanging strip
strip_l     = 70;
groove_w    = 1.15;
groove_d    = 0.40;

/* [Face] */
rim_w    = 2.6;  // black outline thickness
cheek    = 30;   // face sticks out past the head, each side
eye_r    = 5.2;
whisker_t = 1.8;
whisker_l = 18;

$fn = 48;

// ---------------------------------------------------------------------
// Pick the brush
// ---------------------------------------------------------------------
overall_l = (theme == "bunny") ? bun_overall_l : cat_overall_l;
head_w    = (theme == "bunny") ? bun_head_w    : cat_head_w;
head_l    = (theme == "bunny") ? bun_head_l    : cat_head_l;
head_t    = (theme == "bunny") ? bun_head_t    : cat_head_t;
head_base = (theme == "bunny") ? bun_head_base : cat_head_base;
handle_w  = (theme == "bunny") ? bun_neck_w    : cat_neck_w;
handle_t  = (theme == "bunny") ? bun_neck_t    : cat_neck_t;
grip_w    = (theme == "bunny") ? bun_grip_w    : cat_grip_w;
grip_t    = (theme == "bunny") ? bun_grip_t    : cat_grip_t;
handle_l  = overall_l - head_l;

lip_in    = clr_side + lip_in_pad;
slot_w    = handle_w + 2 * clr_side;
slot_d    = handle_t + clr_t;
opening   = slot_w - 2 * lip_in;
y_chan0   = bottom_m;
y_lip1    = y_chan0 + retain_h;
y_shoulder = y_lip1 + entry_h;
z_clear   = back_t + slot_d;
z_top     = z_clear + lip_in + lip_tip;
csk_h     = (screw_csk_d - screw_d) / 2;
use_screws = (mount == "screws" || mount == "both");
use_strip  = (mount == "strip" || mount == "both");

// Face oval. The chin starts below the channel so the cradle sits on the
// plate. Eyes and whiskers sit in the margin the brush does not cover,
// and the ears rise beside (cat) or above (bunny) the head.
cheek_use = (theme == "bunny") ? cheek + 6 : cheek;
face_rx   = head_w / 2 + cheek_use;
chin_y    = y_chan0 - 18;
brow_y    = (theme == "bunny") ? y_shoulder + 92 : y_shoulder + head_l - 28;
face_cy   = (chin_y + brow_y) / 2;
face_ry   = (brow_y - chin_y) / 2;
face_top  = brow_y;
face_bot  = chin_y;

ear_above  = (theme == "bunny") ? 26 : 16;  // ear tip above the top of the brush head
ear_h      = (theme == "bunny") ? 78 : 58;
ear_tip_r  = (theme == "bunny") ? 8.2 : 5.2;
ear_tip_y  = y_shoulder + head_l + ear_above;
ear_base_y = ear_tip_y - ear_h;
plate_top  = ear_tip_y + ear_tip_r;
plate_bot  = chin_y;
plate_h    = plate_top - plate_bot;
plate_w    = face_rx * 2;

module _checks() {
    assert(theme == "cat" || theme == "bunny", "theme must be \"cat\" or \"bunny\"");
    assert(head_w > slot_w + 6, "head is not wider than the channel");
    assert(lip_in > clr_side + 2, "lips do not reach across the neck");
    assert(opening < handle_w - 4, "lip opening is wide enough for the neck to fall out");
    assert(opening > 8, "lip opening is too tight to push the neck in");
    assert(back_t > csk_h + color_h + 0.8, "plate is too thin for the countersink and the colour layer");
    assert(color_h >= 0.4 && color_h <= 1.6, "color_h wants to be a few 0.20 mm layers");
    assert(retain_h > top_taper + bottom_taper + 8, "retain_h is shorter than the lip tapers");
    assert(entry_h >= 20, "entry mouth is too short");
    assert(z_top > z_clear + lip_in + 0.6, "lip tip has no vertical face");
    assert(plate_w <= 230 && plate_h <= 248, str("holder is ", plate_w, " x ", plate_h, " and does not fit the bed"));
    assert(ear_base_y < face_top - 6, "ears do not join the head");
    assert(mount == "screws" || mount == "strip" || mount == "both", "mount must be screws, strip, or both");
}
_checks();

echo(str("KP theme=", theme));
echo(str("KP plate_w=", plate_w));
echo(str("KP plate_h=", plate_h));
echo(str("KP plate_bot=", plate_bot));
echo(str("KP plate_top=", plate_top));
echo(str("KP z_top=", z_top));
echo(str("KP back_t=", back_t));
echo(str("KP color_h=", color_h));
echo(str("KP slot_w=", slot_w));
echo(str("KP slot_d=", slot_d));
echo(str("KP opening=", opening));
echo(str("KP y_chan0=", y_chan0));
echo(str("KP y_shoulder=", y_shoulder));
echo(str("KP retain_h=", retain_h));
echo(str("KP entry_h=", entry_h));
echo(str("KP handle_w=", handle_w));
echo(str("KP handle_t=", handle_t));
echo(str("KP handle_l=", handle_l));
echo(str("KP grip_w=", grip_w));
echo(str("KP grip_t=", grip_t));
echo(str("KP head_w=", head_w));
echo(str("KP head_l=", head_l));
echo(str("KP head_t=", head_t));
echo(str("KP head_base=", head_base));
echo(str("KP overall_l=", overall_l));
echo(str("KP face_rx=", face_rx));
echo(str("KP face_ry=", face_ry));
echo(str("KP face_cy=", face_cy));
echo(str("KP lip_in=", lip_in));
echo(str("KP wall_t=", wall_t));
echo(str("KP clr_side=", clr_side));
echo(str("KP clr_t=", clr_t));
echo(str("KP mount=", mount));

// ---------------------------------------------------------------------
// Silhouette
// ---------------------------------------------------------------------
module face_oval() {
    translate([0, face_cy])
        scale([face_rx, face_ry])
            circle(1, $fn = 96);
}

module cat_ear(s) {
    // Tips sit above the brush head; the outer root clears the head's side.
    hull() {
        translate([s * 16, ear_base_y])      circle(11, $fn = 28);
        translate([s * 50, ear_base_y - 8])  circle(10, $fn = 28);
        translate([s * 34, ear_tip_y])       circle(ear_tip_r, $fn = 22);
    }
}

module bunny_ear(s) {
    // Lean out a little toward the tip.
    hull() {
        translate([s * 27, ear_base_y]) circle(13.5, $fn = 36);
        translate([s * 32, ear_tip_y])  circle(8.2, $fn = 32);
    }
}

module silhouette() {
    face_oval();
    if (theme == "bunny") {
        bunny_ear(-1);
        bunny_ear(1);
    } else {
        cat_ear(-1);
        cat_ear(1);
    }
}

// ---------------------------------------------------------------------
// Black drawing, all in the plane of the plate
// ---------------------------------------------------------------------
module eye_at(x, y) {
    difference() {
        translate([x, y]) scale([1, 1.12]) circle(eye_r, $fn = 40);
        // Catchlight: a hole, so the white plate shows through.
        translate([x - eye_r * 0.32, y + eye_r * 0.34]) circle(eye_r * 0.34, $fn = 24);
    }
}

module whisker(x0, y0, x1, y1) {
    hull() {
        translate([x0, y0]) circle(whisker_t / 2, $fn = 12);
        translate([x1, y1]) circle(whisker_t / 2, $fn = 12);
    }
}

module nose_at(x, y, w) {
    hull() {
        translate([x - w * 0.42, y + w * 0.08]) circle(w * 0.16, $fn = 16);
        translate([x + w * 0.42, y + w * 0.08]) circle(w * 0.16, $fn = 16);
        translate([x, y - w * 0.46])            circle(w * 0.14, $fn = 16);
    }
}

module cat_inner_ear(s) {
    hull() {
        translate([s * 24, ear_base_y + 4])  circle(4.4, $fn = 18);
        translate([s * 42, ear_base_y - 2])  circle(3.8, $fn = 18);
        translate([s * 34, ear_tip_y - 12])  circle(2.2, $fn = 14);
    }
}

module bunny_inner_ear(s) {
    hull() {
        translate([s * 27.4, ear_base_y + 16]) circle(7.2, $fn = 28);
        translate([s * 31.2, ear_tip_y - 16])  circle(3.6, $fn = 24);
    }
}

module black_drawing() {
    difference() {
        silhouette();
        offset(delta = -rim_w) silhouette();
    }
    if (theme == "bunny") {
        eye_at(-50, y_shoulder + 34);
        eye_at( 50, y_shoulder + 34);
        bunny_inner_ear(-1);
        bunny_inner_ear( 1);
        // Nose sits on the plate just above the cradle. The brush covers it.
        nose_at(0, y_shoulder + 8, 11);
    } else {
        // Out on the cheek, beside the head, clear of the strip below them.
        eye_at(-66, y_shoulder + 24);
        eye_at( 66, y_shoulder + 24);
        cat_inner_ear(-1);
        cat_inner_ear( 1);
        nose_at(0, y_shoulder + 6, 11);
    }
    // Three whiskers each side, beside the handle, clear of the cradle
    // and of the strip outlines further out on the cheek.
    for (s = [-1, 1], i = [-1, 0, 1]) {
        y0 = (theme == "bunny" ? y_shoulder - 34 : y_shoulder - 18) + i * 7.5;
        x0 = s * (slot_w / 2 + wall_t + 5);
        x1 = s * (slot_w / 2 + wall_t + 5 + whisker_l);
        whisker(x0, y0, x1, y0 + i * 2.4);
    }
}

// ---------------------------------------------------------------------
// White plate and cradle
// ---------------------------------------------------------------------
module plate_white() {
    linear_extrude(back_t) silhouette();
}

module side_wall(sign) {
    x_inner = sign * slot_w / 2;
    h = retain_h + entry_h;
    ch = shoulder_chamfer;
    // Bite 0.12 mm into the white plate. The black inlay is only at the
    // outline and the face, so the walls land on white.
    translate([x_inner, y_chan0, back_t - 0.12])
        linear_extrude(z_top - (back_t - 0.12))
            polygon(sign > 0
                ? [[0, 0], [wall_t, 0], [wall_t, h], [ch, h], [0, h - ch]]
                : [[0, 0], [-wall_t, 0], [-wall_t, h], [-ch, h], [0, h - ch]]);
}

// Lip cross-section in local XZ. x = 0 is the inner face of the right wall,
// negative x reaches across the neck. The underside rises 1 mm per 1 mm.
module lip_polygon(s) {
    polygon([
        [0.30, z_clear],
        [-s,   z_clear + s + 0.30],
        [-s,   z_top],
        [0.30, z_top]
    ]);
}

module lip_slab(x_inner, y, s) {
    translate([x_inner, y, 0])
        rotate([90, 0, 0])
            linear_extrude(0.24)
                lip_polygon(s);
}

module lip_span(x_inner, y0, y1, s) {
    translate([x_inner, y1, 0])
        rotate([90, 0, 0])
            linear_extrude(y1 - y0)
                lip_polygon(s);
}

module lip_right() {
    x_inner = slot_w / 2;
    y_full0 = y_chan0 + bottom_taper;
    y_full1 = y_chan0 + retain_h - top_taper;
    hull() {
        lip_slab(x_inner, y_chan0 + 0.24, 0.8);
        lip_slab(x_inner, y_full0, lip_in);
    }
    lip_span(x_inner, y_full0 - 0.2, y_full1 + 0.2, lip_in);
    hull() {
        lip_slab(x_inner, y_full1, lip_in);
        lip_slab(x_inner, y_chan0 + retain_h, 0.8);
    }
}

module cradle() {
    side_wall(1);
    side_wall(-1);
    lip_right();
    mirror([1, 0, 0]) lip_right();
}

module screw_hole(x, y) {
    translate([x, y, -0.2])
        cylinder(d = screw_d, h = back_t + 0.4, $fn = 36);
    translate([x, y, back_t - csk_h])
        cylinder(d1 = screw_d, d2 = screw_csk_d, h = csk_h + 0.04, $fn = 36);
}

module screw_holes() {
    // Clear of the eyes, the ears, and the strip outlines.
    if (theme == "bunny") {
        lo = [40, 42];
        hi = [46, 158];
    } else {
        lo = [40, 38];
        hi = [30, 172];
    }
    for (s = [-1, 1]) {
        screw_hole(s * lo[0], lo[1]);
        screw_hole(s * hi[0], hi[1]);
    }
}

module rr_centered(w, h, r) {
    rr = min(r, min(w, h) / 2 - 0.05);
    hull()
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * (w / 2 - rr), sy * (h / 2 - rr)])
                circle(rr, $fn = 28);
}

module strip_outline(cx, cy, w, h) {
    translate([cx, cy, back_t - groove_d])
        linear_extrude(groove_d + 0.08)
            difference() {
                rr_centered(w, h, 3.0);
                rr_centered(w - 2 * groove_w, h - 2 * groove_w, max(0.8, 3.0 - groove_w));
            }
}

module strip_marks() {
    // One medium strip each side. The outline is on the front; the
    // adhesive goes on the flat back, in this same spot.
    // Cat cheeks are beside the lower head. Bunny cheeks are wider.
    if (theme == "bunny") {
        cx = 34; cy = 108; sh = 64;
    } else {
        cx = 48; cy = 112; sh = 64;
    }
    for (s = [-1, 1])
        strip_outline(s * cx, cy, strip_w, sh);
}

module color_recess() {
    translate([0, 0, back_t - color_h])
        linear_extrude(color_h + 0.05)
            black_drawing();
}

module white_solid() {
    difference() {
        union() {
            plate_white();
            cradle();
        }
        color_recess();
        if (use_screws) screw_holes();
        if (use_strip) strip_marks();
    }
}

module black_solid() {
    // Inside the recess, short of its floor and of the plate top, so the
    // white and black meshes do not occupy the same space.
    translate([0, 0, back_t - color_h + color_gap])
        linear_extrude(color_h - 2 * color_gap)
            black_drawing();
}

// Ghost brush for the OpenSCAD preview only. `%` keeps it out of the STL.
module ghost_brush() {
    %color([0.86, 0.55, 0.62, 0.38]) {
        translate([0, y_shoulder + head_l / 2, back_t + head_t / 2])
            cube([head_w, head_l, head_t], center = true);
        translate([0, y_shoulder - handle_l / 2 + 5, back_t + handle_t / 2])
            cube([handle_w, handle_l, handle_t], center = true);
    }
}

if (part == "white") white_solid();
else if (part == "black") black_solid();
else if (part == "preview") {
    color("#f7f4ef") white_solid();
    color("#1c1c1c") black_solid();
} else {
    color("#f7f4ef") white_solid();
    color("#1c1c1c") black_solid();
    ghost_brush();
}
