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
//  theme = "cat"   paddle brush. Wide flat head, jagged cheek tufts,
//                  triangular ears on the top corners.
//  theme = "bunny" pink detangling brush. Tall pear-shaped head,
//                  one ear upright and one floppy.
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
rim_w = 2.6;  // black outline thickness. Features stay inside this.

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

// Design envelope of the silhouette, for the bed check. The exported mesh
// is measured again; these are the boxes the outlines are drawn inside.
// Cat head (without ears) is wider than it is tall. Bunny head is taller
// than it is wide. Ears stay inside the same envelope.
plate_w = (theme == "bunny") ? 172 : 220;
plate_h = (theme == "bunny") ? 242 : 216;

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
    // 256 mm bed, 5 mm auto brim on each side, a couple of millimetres spare.
    assert(plate_w <= 236 && plate_h <= 244, str("holder is ", plate_w, " x ", plate_h, " and does not fit the bed"));
    assert(mount == "screws" || mount == "strip" || mount == "both", "mount must be screws, strip, or both");
}
_checks();

echo(str("KP theme=", theme));
echo(str("KP plate_w=", plate_w));
echo(str("KP plate_h=", plate_h));
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
echo(str("KP rim_w=", rim_w));
echo(str("KP lip_in=", lip_in));
echo(str("KP wall_t=", wall_t));
echo(str("KP clr_side=", clr_side));
echo(str("KP clr_t=", clr_t));
echo(str("KP mount=", mount));

// ---------------------------------------------------------------------
// Silhouette
// The cat head, ears left off, is wider than it is tall: a flat crown
// and three pointed cheek tufts a side. The ears are big triangles on
// the top corners, pointing up, clear of the brush.
// The bunny head is a tall pear, narrow at the crown and round in the
// cheeks. One ear stands up on the left. The other bends over the right
// and hangs down. Both ears start on a wide base buried in the head, so
// the join has no neck. A small round-off keeps the tips printable and
// blends the bunny's ear roots.
// ---------------------------------------------------------------------
module mirror_outline(right) {
    n = len(right);
    pts = [for (i = [0:n - 1]) right[i],
           for (i = [n - 2:-1:1]) [-right[i][0], right[i][1]]];
    polygon(pts);
}

module rounded(r) {
    offset(r = -r) offset(r = r) children();
}

module cat_head() {
    mirror_outline([
        [0, 4], [24, 7], [46, 16], [64, 30], [72, 42],
        [76, 50], [98, 58], [74, 68],
        [82, 78], [108, 92], [80, 106],
        [86, 116], [104, 128], [72, 138],
        [52, 144], [28, 147], [0, 149]
    ]);
}

module cat_ear(s) {
    polygon([[s * 32, 143], [s * 84, 134], [s * 60, 214]]);
}

module bunny_head() {
    // Soften the pear before the ears go on, so the head stays an egg
    // and the ear roots are what get the smaller blend below.
    rounded(6) mirror_outline([
        [0, 8], [24, 11], [44, 22], [58, 40], [68, 62],
        [73, 84], [71, 106], [62, 128], [50, 148],
        [38, 166], [26, 180], [14, 190], [0, 196]
    ]);
}

// Centres and radii of a thick ear. The first circle sits inside the head.
module ear_ribbon(pts, rs) {
    n = len(pts);
    for (i = [0:n - 1])
        translate(pts[i]) circle(rs[i], $fn = 36);
    for (i = [0:n - 2])
        hull() {
            translate(pts[i])     circle(rs[i], $fn = 36);
            translate(pts[i + 1]) circle(rs[i + 1], $fn = 36);
        }
}

module bunny_upright_ear() {
    ear_ribbon(
        [[-12, 155], [-26, 182], [-34, 210], [-30, 234]],
        [16, 12.5, 10, 8]
    );
}

module bunny_floppy_ear() {
    ear_ribbon(
        [[8, 170], [26, 190], [50, 196], [70, 172], [82, 142], [84, 116]],
        [16, 13, 11.5, 11, 10.5, 9]
    );
}

module silhouette() {
    if (theme == "bunny")
        rounded(3.2) {
            bunny_head();
            bunny_upright_ear();
            bunny_floppy_ear();
        }
    else
        rounded(1.3) {
            cat_head();
            cat_ear(1);
            cat_ear(-1);
        }
}

// ---------------------------------------------------------------------
// Black drawing, all in the plane of the plate
// ---------------------------------------------------------------------
module rod(a, b, w) {
    hull() {
        translate(a) circle(w / 2, $fn = 14);
        translate(b) circle(w / 2, $fn = 14);
    }
}

module cat_eye(s) {
    // Almond, outer corner up. The catchlight is a hole, so the white
    // plate shows through. The eye sits on the cheek, beside the brush.
    translate([s * 61, 102]) rotate(s * 20) difference() {
        scale([8.5, 4.0]) circle(1, $fn = 48);
        translate([-3.4, 2.0]) circle(1.65, $fn = 20);
    }
}

module bunny_eye(s) {
    translate([s * 56, 98]) difference() {
        circle(6.4, $fn = 48);
        translate([-s * 1.8, 2.2]) circle(1.8, $fn = 20);
    }
}

module cat_ink() {
    for (s = [-1, 1]) {
        cat_eye(s);
        // Inner ear, inset from the triangle so a white gap remains.
        polygon([[s * 48, 154], [s * 72, 146], [s * 60, 190]]);
    }
    // Triangle nose, point down, with a small W under it.
    translate([0, 82]) polygon([[0, 4.6], [-5.6, -4.0], [5.6, -4.0]]);
    rod([-9.0, 73.6], [-4.4, 69.0], 1.85);
    rod([-4.4, 69.0], [0, 72.6], 1.85);
    rod([0, 72.6], [4.4, 69.0], 1.85);
    rod([4.4, 69.0], [9.0, 73.6], 1.85);
    // Long whiskers across the lower cheek, under the strip and out
    // toward the tufts. They stay inside the outline.
    for (s = [-1, 1]) {
        rod([s * 20, 48], [s * 92, 56], 1.7);
        rod([s * 20, 60], [s * 96, 70], 1.7);
        rod([s * 22, 68], [s * 88, 74], 1.7);
    }
}

module bunny_ink() {
    for (s = [-1, 1]) {
        bunny_eye(s);
        // Short whiskers on the cheek, beside the brush, clear of the eye.
        rod([s * 47, 84], [s * 59.0, 85.6], 1.6);
        rod([s * 47, 78], [s * 60.5, 78.2], 1.6);
        rod([s * 47, 72], [s * 58.0, 70.6], 1.6);
        // Two buck teeth.
        translate([s * 2.5, 67.3]) scale([1.15, 2.15]) circle(1.5, $fn = 28);
    }
    // Y-shaped nose and mouth.
    rod([-4.4, 86.5], [0, 80.6], 1.75);
    rod([ 4.4, 86.5], [0, 80.6], 1.75);
    rod([0, 80.6], [0, 74.6], 1.75);
    // Inner ears follow the ribbons and stop short of the roots and tips.
    ear_ribbon([[-26, 182], [-34, 210], [-30, 228]], [5.2, 4.2, 3.2]);
    ear_ribbon([[26, 190], [50, 196], [70, 172], [82, 148]], [5.4, 4.8, 4.4, 3.8]);
}

module black_drawing() {
    difference() {
        silhouette();
        // Round inset. A straight inset grows spikes in the cheek notches.
        offset(r = -rim_w) silhouette();
    }
    // Keep every feature a little inside the outline, so it cannot fuse
    // with the rim where a tuft or an ear gets narrow.
    intersection() {
        if (theme == "bunny") bunny_ink();
        else cat_ink();
        offset(r = -(rim_w + 1.15)) silhouette();
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
    // Chin and forehead, clear of the eyes, the ears, and the strips.
    // Same holes as before: 4.5 mm with an 8.8 mm countersink.
    lo = (theme == "bunny") ? [36, 36] : [40, 38];
    hi = (theme == "bunny") ? [18, 150] : [12, 122];
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
    // One medium strip each side, on the cheek, clear of the eyes and
    // the whiskers. The outline is on the front; the adhesive goes on
    // the flat back, in this same spot.
    cx = (theme == "bunny") ? 32 : 30;
    cy = (theme == "bunny") ? 100 : 108;
    sh = 64;
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
