// =====================================================================
//  Wall hook for hairbrushes
//  Parametric OpenSCAD model. All units in millimetres.
//
//  The hook prints flat on its back (the face that goes against the wall is
//  on the bed). Each brush hangs bristles-out: the neck slides down a channel
//  and the wider head rests on the two shoulders. Lips along the channel keep
//  the handle from falling off the wall. The lips are 45 degree chamfers, the
//  channel is open at the front and at the bottom, and every other feature
//  rises straight off the bed, so the part needs no supports.
//
//  Coordinates (also the print orientation):
//      X = along the wall, left to right
//      Y = up the wall
//      Z = out from the wall (Z = 0 is the back face, on the bed)
//
//  Parts (select with -D 'part="..."'):
//      "hook"      printable part, exported as-printed (default for STL)
//      "assembly"  the hook plus translucent ghost brushes (preview only;
//                  the ghosts are background geometry and are not exported)
//
//  Measure the brush, then edit the "Brush measurements" block below.
//  The neck is the part of the handle just under the head.
// =====================================================================

/* [Preview] */
part = "assembly"; // [hook, assembly]

/* [Brush measurements] */
// Neck, just under the head. This is the part that sits in the channel.
handle_w      = 26;    // width across the brush (left-right when bristles face you)
handle_t      = 13;    // thickness, bristle side to the back of the handle
// Head. It must be wider than the neck or the brush falls through the slot.
head_w        = 80;    // width across the head (a round brush: the barrel diameter)
head_l        = 100;   // length of the head along the handle (preview and spacing)
head_t        = 22;    // thickness of the head, back to bristle tips (preview)
handle_l      = 115;   // length of the handle below the head (preview only)
// How it sits. A round brush is drawn as a barrel when head_w and head_t match.

/* [How many] */
n_brushes     = 2;     // brushes side by side. Two medium paddles fit a 256 mm bed.
head_gap      = 12;    // empty space between neighbouring heads

/* [Mounting] */
mount         = "both"; // [screws, strip, both]
// Flat-head wood or machine screw. 4.5 mm clears M4 and a #8.
screw_d       = 4.5;   // clearance hole
screw_csk_d   = 8.8;   // countersink diameter (90 degree included angle, opens upward)
// 3M Command picture-hanging strips: medium is 19 x 70, large is 19 x 93.
strip_w       = 19;
strip_l       = 70;    // engraved outline on each wing. Large (93) fits the centre back.

/* [Fit] */
// Clearance around the neck. The X1 Carbon holds this easily in PLA.
clr_side      = 0.8;   // extra channel width, each side of the neck
clr_t         = 1.2;   // extra depth, so the neck slides under the lips
lip_in        = 4.8;   // how far each lip reaches across the neck. The underside is 45 deg.
wall_t        = 4.8;   // channel wall thickness (also the shoulder the head sits on)
back_t        = 4.2;   // back plate thickness. Needs room for the countersink.
bottom_m      = 28;    // plate below the channel (handle backrest, lower screws, strip)
retain_h      = 34;    // length of neck captured behind the lips
entry_h       = 26;    // open mouth above the lips, where the neck goes in
backrest_h    = 32;    // plate above the shoulders, behind the head
side_m        = 18;    // plate outside the outer heads (screws and strip wings)
corner_r      = 12;    // back-plate corner radius
lip_tip       = 1.8;   // vertical face on top of the 45 deg lip, so the tip is not sharp
shoulder_chamfer = 1.0;
top_taper     = 7;     // lip eases in over this distance at the top of the channel
bottom_taper  = 5;     // and at the bottom, so the neck does not snag on the way out
screw_inset   = 14;    // screw centres, in from the plate edge
plate_chamfer = 1.0;   // top-edge chamfer of the back plate (upward-facing steps)
groove_w      = 1.15;  // engraved strip-outline line width
groove_d      = 0.45;  // engraved depth (a couple of layers)

$fn = 32;

// ---------------------------------------------------------------------
// DERIVED (don't edit)
// ---------------------------------------------------------------------
slot_w   = handle_w + 2 * clr_side;
pitch    = head_w + head_gap;
plate_w  = n_brushes * head_w + max(0, n_brushes - 1) * head_gap + 2 * side_m;
y_chan0  = bottom_m;
y_lip1   = y_chan0 + retain_h;             // lips end, open mouth begins
y_shoulder = y_lip1 + entry_h;             // head rests on this edge
plate_h  = y_shoulder + backrest_h;
z_clear  = back_t + handle_t + clr_t;      // lips start in front of the neck
z_top    = z_clear + lip_in + lip_tip;     // front of the walls and lips
csk_h    = (screw_csk_d - screw_d) / 2;    // 90 deg countersink: run equals rise
opening  = slot_w - 2 * lip_in;            // gap between the lip tips
// Flat wing outside each outer cradle, where a strip outline is engraved.
wing_w   = head_w / 2 - slot_w / 2 - wall_t + side_m;
// Keep the strip outlines off the countersunk heads when both are fitted.
strip_pad = (mount == "both") ? screw_inset + screw_csk_d / 2 + 3 : 8;
strip_avail = plate_h - 2 * strip_pad;
strip_mark_l = min(strip_l, strip_avail);
use_screws = (mount == "screws" || mount == "both");
use_strip  = (mount == "strip" || mount == "both");

echo(str("plate ", plate_w, " x ", plate_h, " x ", z_top,
         " mm, slot ", slot_w, " x ", handle_t + clr_t,
         " mm, lip opening ", opening, " mm, wing ", wing_w, " mm"));
echo(str("shoulders at y=", y_shoulder, ", channel from y=", y_chan0,
         " to y=", y_shoulder, ", strip mark ", strip_w, " x ", strip_mark_l));

module _checks() {
    assert(n_brushes >= 1, "n_brushes must be at least 1");
    assert(head_w > slot_w + 4,
        "head is not wider than the channel: the brush would fall through. Measure head_w across the head, or reduce handle_w.");
    assert(lip_in > clr_side + 2,
        "lips do not reach across the neck. Increase lip_in (keep the 45 deg underside).");
    assert(opening < handle_w - 4,
        "lip opening is wide enough for the neck to fall out the front. Increase lip_in or reduce clr_side.");
    assert(z_top > z_clear + lip_in + 0.6, "lip tip has no vertical face. Increase lip_tip.");
    assert(back_t > csk_h + 1.5, "back plate is too thin for the countersink. Increase back_t or reduce screw_csk_d.");
    assert(csk_h > 0, "countersink must be wider than the screw hole");
    assert(retain_h > top_taper + bottom_taper + 10, "retain_h is shorter than the lip tapers");
    assert(entry_h >= 20, "entry mouth is too short to push the neck in. Increase entry_h.");
    assert(pitch > slot_w + 2 * wall_t + 3, "cradles overlap. Increase head_gap or head_w.");
    assert(plate_w <= 246 && plate_h <= 246,
        str("hook is ", plate_w, " x ", plate_h, " mm and does not fit the 256 mm X1 Carbon bed"));
    if (use_strip) {
        // 2 mm of plate each side of the engraved outline is enough; a round
        // brush has a narrower head, so the wing is smaller than a paddle's.
        assert(wing_w >= strip_w + 4,
            "side wing is too narrow for a Command strip outline. Increase side_m.");
        assert(strip_avail >= strip_l - 0.1,
            str("only ", strip_avail, " mm of height is clear for a ", strip_l,
                " mm strip. Lower strip_l, or raise bottom_m and backrest_h."));
    }
    assert(mount == "screws" || mount == "strip" || mount == "both",
        "mount must be \"screws\", \"strip\", or \"both\"");
    assert(bottom_m > screw_inset + screw_csk_d / 2 + 1, "bottom skirt does not clear the lower screws");
    assert(backrest_h > screw_inset + screw_csk_d / 2 + 1, "backrest does not clear the upper screws");
}
_checks();

// Machine-readable dimensions for the viewer. One number or word per line.
module _echo_params() {
    echo(str("KP plate_w=", plate_w));
    echo(str("KP plate_h=", plate_h));
    echo(str("KP z_top=", z_top));
    echo(str("KP corner_r=", corner_r));
    echo(str("KP n_brushes=", n_brushes));
    echo(str("KP pitch=", pitch));
    echo(str("KP head_gap=", head_gap));
    echo(str("KP y_chan0=", y_chan0));
    echo(str("KP y_shoulder=", y_shoulder));
    echo(str("KP retain_h=", retain_h));
    echo(str("KP entry_h=", entry_h));
    echo(str("KP slot_w=", slot_w));
    echo(str("KP wall_t=", wall_t));
    echo(str("KP back_t=", back_t));
    echo(str("KP z_clear=", z_clear));
    echo(str("KP lip_in=", lip_in));
    echo(str("KP opening=", opening));
    echo(str("KP handle_w=", handle_w));
    echo(str("KP handle_t=", handle_t));
    echo(str("KP handle_l=", handle_l));
    echo(str("KP head_w=", head_w));
    echo(str("KP head_l=", head_l));
    echo(str("KP head_t=", head_t));
    echo(str("KP clr_t=", clr_t));
    echo(str("KP clr_side=", clr_side));
    echo(str("KP slot_d=", handle_t + clr_t));
    echo(str("KP mount=", mount));
    echo(str("KP screw_d=", screw_d));
    echo(str("KP screw_csk_d=", screw_csk_d));
    echo(str("KP screw_inset=", screw_inset));
    echo(str("KP strip_w=", strip_w));
    echo(str("KP strip_l=", strip_l));
    echo(str("KP strip_mark_l=", strip_mark_l));
    echo(str("KP wing_w=", wing_w));
    echo(str("KP bottom_m=", bottom_m));
    echo(str("KP backrest_h=", backrest_h));
    echo(str("KP side_m=", side_m));
}
_echo_params();

// ---------------------------------------------------------------------
// BACK PLATE
// ---------------------------------------------------------------------
module plate_outline() {
    translate([-plate_w / 2, corner_r])
        hull()
            for (px = [corner_r, plate_w - corner_r],
                 py = [0, plate_h - 2 * corner_r])
                translate([px, py])
                    circle(corner_r, $fn = 56);
}

// Full-height slab, then a few upward-facing steps that read as a 1 mm chamfer.
// The steps shrink toward the top, so nothing overhangs downward.
module back_plate() {
    ch = plate_chamfer;
    n = 4;
    linear_extrude(back_t - ch) plate_outline();
    for (i = [0 : n - 1]) {
        inset = ch * i / n;
        z0 = back_t - ch + ch * i / n;
        h = (i == n - 1) ? (back_t - z0) : (ch / n + 0.02);
        translate([0, 0, z0])
            linear_extrude(h)
                offset(delta = -inset)
                    plate_outline();
    }
}

// ---------------------------------------------------------------------
// CHANNEL WALLS AND 45 DEGREE LIPS
// ---------------------------------------------------------------------
// One wall. sign = +1 on the right of a station, -1 on the left.
// The polygon is the top view (XY); it is extruded out from the wall.
module side_wall(cx, sign) {
    x_inner = cx + sign * slot_w / 2;
    h = retain_h + entry_h;
    ch = shoulder_chamfer;
    translate([x_inner, y_chan0, back_t - 0.05])
        linear_extrude(z_top - (back_t - 0.05))
            polygon(sign > 0
                ? [[0, 0], [wall_t, 0], [wall_t, h], [ch, h], [0, h - ch]]
                : [[0, 0], [-wall_t, 0], [-wall_t, h], [-ch, h], [0, h - ch]]);
}

// Lip cross-section in local XZ. x = 0 is the inner face of the right wall,
// positive x is into the wall, negative x reaches across the neck.
// The long underside rises 1 mm in Z for every 1 mm it reaches inward (45 deg).
module lip_polygon(s) {
    polygon([
        [0.30, z_clear],
        [-s,   z_clear + s + 0.30],
        [-s,   z_top],
        [0.30, z_top]
    ]);
}

// A thin sheet of that cross-section, standing in the XZ plane at height y.
// rotate([90,0,0]) maps 2D (x, y) to (X, Z) and the extrusion runs toward -Y,
// so the sheet occupies Y from (y - thick) to y.
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

// Right-hand lip of one station. Tapers at both ends so the neck slides in
// and out; the middle is the full lip. Hull of two 45 deg profiles stays on
// the same 45 deg plane (see the build notes in the README).
module lip_right(cx) {
    x_inner = cx + slot_w / 2;
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

module station(cx) {
    side_wall(cx, 1);
    side_wall(cx, -1);
    lip_right(cx);
    // Mirror the right lip across the station centre to make the left lip.
    translate([2 * cx, 0, 0])
        mirror([1, 0, 0])
            lip_right(cx);
}

module cradles() {
    for (i = [0 : n_brushes - 1]) {
        cx = (i - (n_brushes - 1) / 2) * pitch;
        station(cx);
    }
}

// ---------------------------------------------------------------------
// SCREWS AND COMMAND-STRIP MARKS (cut from the front face)
// ---------------------------------------------------------------------
module screw_hole(x, y) {
    translate([x, y, -0.1])
        cylinder(d = screw_d, h = back_t + 0.3, $fn = 40);
    // Wide end at the front (high Z): an upward-opening cone, supported as it prints.
    translate([x, y, back_t - csk_h])
        cylinder(d1 = screw_d, d2 = screw_csk_d, h = csk_h + 0.06, $fn = 40);
}

module screw_holes() {
    for (sx = [-1, 1], sy = [screw_inset, plate_h - screw_inset])
        screw_hole(sx * (plate_w / 2 - screw_inset), sy);
}

module rr_centered(w, h, r) {
    rr = min(r, min(w, h) / 2 - 0.05);
    hull()
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * (w / 2 - rr), sy * (h / 2 - rr)])
                circle(rr, $fn = 36);
}

// Outline only, so the back face behind it stays flat for the adhesive.
module strip_outline(cx, cy, w, h) {
    translate([cx, cy, back_t - groove_d])
        linear_extrude(groove_d + 0.12)
            difference() {
                rr_centered(w, h, 3.2);
                rr_centered(w - 2 * groove_w, h - 2 * groove_w, max(0.8, 3.2 - groove_w));
            }
}

module center_tick(cy, len) {
    translate([0, cy, back_t - groove_d])
        linear_extrude(groove_d + 0.12)
            square([1.3, len], center = true);
}

module strip_marks() {
    cy = plate_h / 2;
    for (sx = [-1, 1]) {
        cx = sx * (plate_w / 2 - wing_w / 2);
        strip_outline(cx, cy, strip_w, strip_mark_l);
    }
    // Short ticks on the centre line: a large (19 x 93) strip fits here on the
    // back, between the corner screws, if you would rather use one strip.
    center_tick(plate_h - 14, 8);
    center_tick(14, 8);
}

// ---------------------------------------------------------------------
// THE HOOK
// ---------------------------------------------------------------------
module hook() {
    difference() {
        union() {
            back_plate();
            cradles();
        }
        if (use_screws) screw_holes();
        if (use_strip) strip_marks();
    }
}

// Ghost brush for the on-screen preview. `%` keeps it out of the STL.
module ghost_brush(cx) {
    %color([0.72, 0.42, 0.32, 0.35]) {
        translate([cx, y_shoulder + 0.4 + head_l / 2, back_t + 0.3 + head_t / 2])
            cube([head_w, head_l, head_t], center = true);
        translate([cx, y_shoulder - handle_l / 2 + 4, back_t + handle_t / 2])
            cube([handle_w, handle_l, handle_t], center = true);
    }
}

module assembly() {
    hook();
    for (i = [0 : n_brushes - 1])
        ghost_brush((i - (n_brushes - 1) / 2) * pitch);
}

if (part == "hook") hook();
else assembly();
