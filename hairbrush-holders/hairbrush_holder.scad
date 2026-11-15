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
//  theme = "cat"   paddle brush. Hello Kitty-style: a wide flat oval,
//                  small oval eyes, an outlined nose, three whiskers,
//                  short rounded ears, and a bow centered between them.
//  theme = "bunny" pink detangling brush. The same Hello Kitty-style
//                  face, with long upright ears and the bow on the forehead.
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
rim_w = 2.8;  // even black outline. Features stay inside this.

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
// Both plates are the same wide oval. The bunny is taller because of the ears.
plate_w = 232;
plate_h = (theme == "bunny") ? 238 : 208;

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
// Silhouette. The right side is drawn once and mirrored, so the plate
// is symmetric about x = 0. rounded() is an expand-then-shrink: it
// turns corners into arcs and fillets the ear join.
// Both faces share one Hello Kitty-style head. Whiskers and the bow are
// added after the fillet, so the outline stays smooth and the thin
// whiskers are not eaten by the shrink.
// ---------------------------------------------------------------------
module rounded(r) {
    offset(r = -r) offset(r = r) children();
}

// Wider than tall. The chin drops low enough to back the cradle.
module head() {
    translate([0, 112]) scale([98, 86]) circle(1, $fn = 96);
}

module cat_ear() {
    // Short rounded triangle. The tip is a circle, so it cannot come to a point.
    hull() {
        translate([46, 180]) circle(13, $fn = 40);
        translate([74, 174]) circle(12, $fn = 40);
        translate([60, 214]) circle(16, $fn = 40);
    }
}

module bunny_ear() {
    hull() {
        translate([18, 190]) circle(15.5, $fn = 40);
        translate([30, 246]) circle(15.5, $fn = 40);
    }
}

module ear() {
    if (theme == "bunny") bunny_ear();
    else cat_ear();
}

// Head and ears only. The rim follows this, not the whiskers or the bow.
module face_outline() {
    rounded(5) {
        head();
        ear();
        mirror([1, 0, 0]) ear();
    }
}

// Bow size and height. The cat bow sits on the crown, between the ears.
// The bunny bow sits on the forehead, under the long ears, and is a
// little bigger so the loops still show beside the narrower brush.
bow_s = (theme == "bunny") ? 1.24 : 1.0;
// Both bows sit fully on the head. The cat's is between the ear bases.
bow_y = (theme == "bunny") ? 170 : 178;

// One loop, built on y = 0: fat at the outer end, pinched toward x = 0,
// tipped up by 13 degrees. The caller mirrors it and lifts it.
module bow_loop() {
    translate([15 * bow_s, 0])
        rotate([0, 0, -13])
            translate([-15 * bow_s, 0])
                hull() {
                    translate([23 * bow_s, 0]) circle(13.5 * bow_s, $fn = 48);
                    translate([7.5 * bow_s, 0]) circle(5.6 * bow_s, $fn = 36);
                }
}

module bow_solid() {
    translate([0, bow_y]) {
        bow_loop();
        mirror([1, 0, 0]) bow_loop();
        circle(7.0 * bow_s, $fn = 48);
    }
}

module whisker(a, b) {
    hull() {
        translate(a) circle(0.85, $fn = 14);
        translate(b) circle(0.85, $fn = 14);
    }
}

module whiskers() {
    for (s = [-1, 1])
        scale([s, 1]) {
            whisker([52, 96], [110, 103]);
            whisker([52, 88], [114, 88]);
            whisker([52, 80], [110, 73]);
        }
}

// White plate: the face, plus pads under the whiskers and the bow.
module silhouette() {
    face_outline();
    whiskers();
    bow_solid();
}

// ---------------------------------------------------------------------
// Black drawing, all in the plane of the plate. Every stroke is at
// least 1.2 mm, so a 0.4 mm nozzle can hold it.
// ---------------------------------------------------------------------
module eyes() {
    for (s = [-1, 1])
        translate([s * 70, 100]) scale([6.0, 4.0]) circle(1, $fn = 48);
}

// Outlined oval. The real nose is yellow; the white plate stands in for it.
module nose() {
    translate([0, 84]) difference() {
        scale([5.6, 3.8]) circle(1, $fn = 56);
        offset(r = -1.55) scale([5.6, 3.8]) circle(1, $fn = 56);
    }
}

module bunny_inner() {
    for (s = [-1, 1])
        scale([s, 1]) difference() {
            hull() {
                translate([20, 208]) circle(6.4, $fn = 32);
                translate([28, 236]) circle(6.4, $fn = 32);
            }
            hull() {
                translate([20, 208]) circle(4.7, $fn = 32);
                translate([28, 236]) circle(4.7, $fn = 32);
            }
        }
}

// Two loop outlines and a round knot. The knot covers the pinch.
module bow_ink() {
    kr = 7.0 * bow_s;
    translate([0, bow_y]) {
        difference() {
            union() {
                difference() {
                    bow_loop();
                    offset(r = -1.85) bow_loop();
                }
                mirror([1, 0, 0]) difference() {
                    bow_loop();
                    offset(r = -1.85) bow_loop();
                }
            }
            circle(kr - 0.2, $fn = 48);
        }
        difference() {
            circle(kr, $fn = 48);
            circle(kr - 1.85, $fn = 40);
        }
    }
}

// The cradle walls land on the chin. Keep the recess off them so it
// cannot cut a notch into the bottom of a wall.
module cradle_keepout() {
    pad = 1.8;
    x0 = slot_w / 2 - 0.6;
    x1 = slot_w / 2 + wall_t + pad;
    h = y_shoulder - y_chan0 + 3;
    for (s = [-1, 1])
        translate([s * (x0 + x1) / 2, y_chan0 - 1.5 + h / 2])
            square([x1 - x0, h], center = true);
}

module black_ink() {
    // Even outline of the head and ears. It stops inside the bow, so
    // the head line does not cut through the loops.
    difference() {
        difference() {
            face_outline();
            offset(r = -rim_w) face_outline();
        }
        offset(r = -0.6) bow_solid();
    }
    // Eyes, nose, and the bunny's inner ears stay off the rim.
    intersection() {
        union() {
            eyes();
            nose();
            if (theme == "bunny") bunny_inner();
        }
        offset(r = -(rim_w + 1.2)) face_outline();
    }
    // Whiskers cross the outline, so they are only trimmed a hair.
    intersection() {
        whiskers();
        offset(r = -0.12) silhouette();
    }
    bow_ink();
}

module black_drawing() {
    difference() {
        black_ink();
        cradle_keepout();
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
    lo = (theme == "bunny") ? [34, 48] : [34, 44];
    hi = (theme == "bunny") ? [26, 126] : [22, 140];
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
    cx = 36;
    cy = (theme == "bunny") ? 112 : 118;
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

// offset() does not retessellate a symmetric outline onto mirrored
// vertices. Cut the finished solid in half and mirror it, so the mesh
// that gets sliced is symmetric about x = 0. The 0.02 mm overlap lets
// the two halves fuse along the centre line.
module mirrored() {
    intersection() {
        children();
        translate([-0.02, -30, -1]) cube([260, 360, 70]);
    }
    mirror([1, 0, 0])
        intersection() {
            children();
            translate([-0.02, -30, -1]) cube([260, 360, 70]);
        }
}

if (part == "white") mirrored() white_solid();
else if (part == "black") mirrored() black_solid();
else if (part == "preview") {
    color("#f7f4ef") mirrored() white_solid();
    color("#1c1c1c") mirrored() black_solid();
} else {
    color("#f7f4ef") mirrored() white_solid();
    color("#1c1c1c") mirrored() black_solid();
    ghost_brush();
}
