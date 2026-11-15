# Hairbrush hook

_Designed by a Cursor cloud agent running Grok 4.7 High Fast, Nov 14, 2026._

A one-piece wall hook that holds hairbrushes by the neck, head up and bristles
facing out. The wider head rests on two shoulders. Lips along the channel keep
the handle from falling off the wall. The channel is open at the bottom, so a
long handle hangs through.

It prints flat on its back (the face that goes against the wall is on the bed).
The lip undersides are 45° chamfers, and every other feature rises straight off
the bed, so the part needs no supports.

The numbers below are for two medium paddle brushes. Eric does not have calipers
on the real brushes yet, so every measurement is a variable at the top of
`hairbrush_hook.scad`. The exported STL, 3MF, and viewer match those defaults.

Open **`out/viewer.html`** for an interactive view: orbit, zoom, a dimension
readout, and a translucent ghost brush seated in each cradle. The page loads
three.js from unpkg, so the 3D view needs a network. The STL is embedded in the
page, so the model and the STL download still work from `file://`. On a phone,
**📦 Get the files** uses the Web Share API ("Open in…", Files, Bambu Handy).
Where that API is missing, the same button downloads the file. A 3MF opened
from `file://` falls back to a plain link; GitHub Pages serves the files over
HTTP, so the share and download paths both work there.

## What to measure

Measure the **neck**, the part of the handle just under the head, and the
**head**. Hold the brush with the bristles facing you.

```
        |<—— head_w ——>|
        +--------------+  ┐
        |    head       |  head_l   (preview and spacing)
        +--------------+  ┘
           | neck |  ┐
           |      |  handle_t is front-to-back at this same spot
           |      |  ┘
           +------+
        |<>| handle_w
```

| Variable | What to measure | Default | Changes the printed part |
|---|---|---|---|
| `handle_w` | Neck width, left to right | 26 mm | Channel width |
| `handle_t` | Neck thickness, bristle side to the back of the handle | 13 mm | Channel depth and how far the lips stand off the wall |
| `head_w` | Widest part of the head. For a round brush, the barrel diameter | 80 mm | How far apart the cradles sit, and the plate width |
| `head_l` | Head length along the handle | 100 mm | Ghost brush in the viewer only |
| `head_t` | Head thickness, back of the head to the bristle tips | 22 mm | Ghost brush in the viewer only |
| `handle_l` | Handle length below the head | 115 mm | Ghost brush in the viewer only |
| `n_brushes` | How many brushes side by side | 2 | Plate width |
| `head_gap` | Empty space you want between neighbouring heads | 12 mm | Cradle spacing |
| `mount` | `"screws"`, `"strip"`, or `"both"` | `"both"` | Screw holes and the engraved strip marks |

With the defaults, the channel is 27.6 mm wide and 14.2 mm deep. Each lip
reaches 4.8 mm across the neck, leaving an 18 mm opening, so a neck from about
18 mm to 26 mm wide is held. A wider neck needs a larger `handle_w`. A neck
narrower than about 18 mm needs a smaller `handle_w` (the opening shrinks with
it). The head has to be wider than the channel or the brush falls through;
the model refuses to build when `head_w` is not at least 4 mm wider than the
slot. The neck should stay about that wide for the 34 mm the lips capture
(`retain_h`). A grip that flares or pinches inside that 34 mm will sit loose
or bind.

### A round brush

A typical round brush is closer to:

```
handle_w = 18;  handle_t = 18;
head_w   = 45;  head_l   = 70;  head_t = 45;
```

That builds a 138 × 120 × 30 mm plate, a 19.6 × 19.2 mm slot, a 10 mm lip
opening, and a 25.9 mm side wing. The viewer draws a barrel when `head_w` and
`head_t` are within 12% of each other. Those numbers are a starting guess, the
same as the paddle defaults: measure the real brush and edit the file.

Two 80 mm paddle heads fit a 256 mm bed (the plate is 208 mm wide). Three do
not; the model stops if the plate exceeds 246 mm in either direction, leaving
room for a skirt and the X1 Carbon's front-left exclusion zone.

## How to change the numbers

The parameters are in named Customizer groups at the top of
`hairbrush_hook.scad` (`Brush measurements`, `How many`, `Mounting`, `Fit`).
Edit them, then export the printable part (the ghost brushes are `%` geometry
and stay out of the STL):

```bash
openscad -D 'part="hook"' -o out/hairbrush_hook.stl hairbrush_hook.scad
```

A round-brush export from the defaults, without editing the file:

```bash
openscad -D 'part="hook"' \
  -D 'handle_w=18' -D 'handle_t=18' \
  -D 'head_w=45' -D 'head_l=70' -D 'head_t=45' \
  -o out/hairbrush_hook.stl hairbrush_hook.scad
```

OpenSCAD 2021.01 is what this was built with. The committed STL, 3MF, and
viewer match the paddle defaults. After you change a number that affects the
solid, re-export before printing. The ghosts in `viewer.html` are drawn by
three.js from the same default numbers; they are not in the mesh.

`part = "assembly"` (the default when you open the file) shows the hook plus
the ghost brushes in the OpenSCAD preview. `part = "hook"` is the printable
solid.

## How a brush goes in

Bristles face out, the back of the handle against the plate.

1. Push the neck into the open mouth just under the shoulders.
2. Slide it down until the head rests on the two shoulders.
3. To take it out, lift about 34 mm so the neck clears the lips, then pull it
   forward.

The butt of the handle never has to pass through the lips. There is no floor
in the channel; a floor would stop a long handle before the head could seat.

## Mounting

**Screws.** Four countersunk holes, one at each corner, 14 mm in from the
edges. The hole is 4.5 mm (M4 or a #8) and the countersink is 8.8 mm at a 90°
included angle, opening toward the front of the print so it needs no support.
The plate is 4.2 mm thick. Use a flat-head screw into a stud or a proper
anchor, and don't overtighten PLA.

**Command strips.** Each side wing has an engraved 19 × 70 mm outline, the
size of a medium 3M Command picture-hanging strip. Two pairs of medium strips
are rated to 2.5 kg. Short ticks on the centre line mark where a single large
strip (19 × 93 mm) fits on the flat back, between the corner screws. If you
use both screws and strips, keep the adhesive off the screw holes.

The back face is the face that was on the bed. A textured PEI pattern is a
poor surface for Command adhesive. Print this on the smooth plate, or sand the
back and wipe it with isopropyl alcohol before you stick the strips. Press
them the way Command's instructions say.

## Print

| | |
|---|---|
| Printer | Bambu Lab X1 Carbon, 0.4 mm nozzle |
| Filament | Bambu PLA Basic |
| Layer height | 0.20 mm |
| Walls / infill | 2 walls, 15% infill (0.20 mm Standard @BBL X1C) |
| Supports | Off. Tree supports at a 30° threshold also add 0 g |
| Orientation | Back face on the bed, as exported. |

Sliced with OrcaSlicer 2.5.1 using the Bambu Lab X1 Carbon 0.4 nozzle machine
profile, the 0.20 mm Standard @BBL X1C process, and Bambu PLA Basic @BBL X1C
(density 1.26 g/cm³).

| | Supports off | Supports on (tree auto, 30°) |
|---|---|---|
| Model printing time | 1 h 40 m 52 s | 1 h 40 m 52 s |
| Total estimated time | 1 h 48 m 8 s | 1 h 48 m 8 s |
| Filament | 82.65 g (65.60 cm³, 27.27 m) | 82.65 g |
| Support | 0 g | 0 g |
| Layers | 125, max Z 25.00 mm | 125 |

The total includes Orca's automatic brim: 1.19 g and about 3.5 minutes. The
footprint is large enough to print with the brim turned off. Orca also reports
9.36 g of "Internal Bridge"; that is the solid skin over the 15% infill, and
the mesh itself has no bridge.

A separate check of the STL: 3,124 triangles, one watertight solid, bounding
box 208 × 120 × 25 mm. Down-facing area flatter than 45°, ignoring the bed
contact, is 0 mm². The lip undersides sit on exactly 45° (about 790 mm²).

`out/hairbrush_hook_plate.3mf` is the same hook shifted onto the bed
(X 32–240 mm, Y 68–188 mm) so it clears the X1 Carbon's front-left 18 × 28 mm
exclusion zone, including a 5 mm brim. The per-part STL and 3MF stay in part
coordinates (X centred, Y from 0, Z from 0) for arranging the plate yourself.

## Files

| File | What it is |
|---|---|
| `hairbrush_hook.scad` | Parametric source |
| `out/hairbrush_hook.stl` | Printable hook, binary STL, 153 KB |
| `out/hairbrush_hook.3mf` | Same mesh, millimetre 3MF |
| `out/hairbrush_hook_plate.3mf` | Same mesh, placed on the X1 Carbon bed |
| `out/viewer.html` | Phone-friendly three.js viewer, with the ghost brushes and the file panel |

## Untested

Nothing here has been printed, and the brushes have not been measured.

- Whether a real neck fits the 27.6 × 14.2 mm default slot, and whether that
  neck stays the same width for the 34 mm the lips capture.
- Command-strip adhesion on a textured PEI back. Use the smooth plate, or
  sand and wipe the back, before trusting the rating.
- How the four screws hold in a particular wall. The holes are clearance
  holes; the wall and the anchors do the holding.
- The round-brush preset above compiles and the asserts pass. It was not
  re-sliced, and it is not the mesh in `out/`.
