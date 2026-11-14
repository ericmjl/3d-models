# Bear Buddy: a 3D-printable sticker-roll dispenser

_Designed by Claude Code running Claude Opus 5.5 (`claude-opus-5-5`), Nov 14, 2026._

A dispenser for a roll of round reward stickers (stickers on a paper liner wound on a
cardboard core). The roll sits on a snap-in spool axle. When you pull the liner tail,
the liner wraps sharply around a peel edge and the next sticker carries straight on and
lifts off, ready to grab. The side cheeks are bear heads, and the axle button is the
nose.

This is the round-2 design, optimised for printing. Every part prints with **zero
support material**, and the whole plate prints in **2 h 49 min** (down from 3 h 59 min
in round 1). `OPTIMIZE_RESULTS.md` has the measurements and what changed.

![assembly](out/preview_assembly_front.png)
![peel edge](out/viewer_peeling.png)

Open **`out/viewer.html`** in a browser for an interactive 3D view. It animates the roll
turning, the liner running over the peel edge, and a sticker lifting off. It has
play/pause, a scrub slider, a show/hide-roll toggle, and a see-through mode that shows
the liner path. The page loads three.js from a CDN (unpkg), so it needs an internet
connection. The STLs are embedded, so it works straight from `file://`.

The viewer's **📦 Get the files** button (top right) lists the plate 3MF and every part
as 3MF and STL; the list is generated from whatever is in `out/`.
- **Phones.** Tapping a file opens the share sheet ("Open in…", Files, Bambu Handy…)
  through the Web Share API.
- **Elsewhere.** It downloads the file. From `file://`, the STLs are rebuilt from the
  geometry embedded in the page.

## Parts

| File | What it is | Print orientation | Size | Bambu estimate |
|---|---|---|---|---|
| `out/base.stl` / `.3mf` | Base, both bear-head cheeks, peel deck, liner keeper bar and lower guide bar, in one piece | Flat on its bottom, as exported | 84 × 148 × 100 mm | 2 h 35 min, 108 g |
| `out/axle.stl` / `.3mf` | Spool axle. The button ends keep it in place, the journals snap into the cheek slots, and six fins fill the cardboard core | Standing upright, as exported | Ø36.7 × 54 mm | 22 min, 7 g |
| `out/sticker_dispenser_plate.3mf` | Both parts laid out on one plate | | | 2 h 49 min, 115 g |

The estimates are from the Bambu Studio CLI with the stock "0.20mm Standard @BBL X1C"
process (2 walls, 15% infill), the X1 Carbon 0.4 mm nozzle profile and Bambu PLA Basic.
`tools/slice_report.py` reproduces them.

The base also has these features:

- **Weight bay.** An open-top bay, 31 × 78 × 6 mm, sits in the base between the cheeks,
  hidden under the roll. It holds three stacks of three US quarters or 1-euro coins
  (about 50 g), or steel washers.
  - Glue the weights in (hot glue or epoxy) so a child can't pick them out.
  - It is on the top because a pocket on the underside would need a ceiling. A
    support-free 45° ceiling over a 25 mm coin needs 12 mm of height above the coins,
    which the 10 mm base doesn't have.
- **Feet.** Four Ø10.5 × 1 mm recesses on the underside for stick-on silicone bumper
  feet. Use them: they stop the dispenser sliding when a child pulls the liner.
- **Decoration.** Debossed stars on the top, and a debossed bear face (eyes, blush,
  smile, inner ears) on both cheeks.

## Print settings (Bambu Studio / OrcaSlicer, PLA)

- **Supports: off.** No part needs them. With Bambu's tree(auto) supports switched on
  at the default 30° threshold, the slicer still generates 0 g, and
  `tools/slice_report.py` checks this.
  - Every down-facing surface is at 45° or steeper (`tools/overhangs.py` finds none
    flatter).
  - The two bars between the cheeks have V-shaped 45° undersides, not flat bridges.
- **Profile.** Use Bambu's stock "0.20mm Standard" (2 walls, 15% grid infill), which is
  what the time and gram figures assume. If you want sturdier journals, print the axle
  with 4 walls; it adds about a minute.
- **Peel edge.** It is a 45° knife edge (`peel_angle`). Print it as it comes out; a
  slightly rounded 0.2–0.3 mm tip still peels well. Don't sand it blunt.
- **Bed adhesion.** No brim is needed for the base. The finned axle stands on a Ø14 mm
  button; add a 5 mm brim if your bed is slippery.
- **Colours.** The previews use sky blue for the base and sunshine yellow for the axle.
  On an AMS you can swap filament for the top layers of the face deboss.

## Assembly and loading a roll

1. Slide the roll's cardboard core onto the axle fins. The fins are 0.4 mm smaller than
   the core on each side. The buttons pass through the core.
2. Thread the liner, stickers facing up:
   - over the deck and under the small keeper bar,
   - forward to the sharp front edge,
   - down behind the lower guide bar, then under its V and out of the front of the base.

   The liner wraps about 125° around the peel edge. That sharp bend is what peels the
   sticker.
3. Drop the axle journals into the U-slots at the top of the bear heads and press down
   until they click past the snap bump. The axle and the roll turn together; the
   journals turn in the slots.
4. To dispense, pull the liner tail forward or down. Lift the next sticker off the front
   edge.

To swap rolls, pull the axle up out of the slots. The flexible tine beside each slot
lets it go.

## Assumed dimensions and how to adjust them

The roll dimensions were estimated from photos (method in `DIMENSIONS.md`):

| Dimension | Value used |
|---|---|
| Roll width | 33 mm |
| Core inner diameter | 37.5 mm |
| Roll outer diameter, as photographed | 50 mm |
| Largest roll the dispenser holds | 80 mm |

**Measure your roll with calipers first.** Then edit the parameters at the top of
`sticker_dispenser.scad`, or pass them on the command line:

```sh
./build.sh -D roll_width=33.5 -D core_id=38.1
```

Main parameters and clearances:

| Parameter | Default | Effect |
|---|---|---|
| `roll_width` | 33 | Cheek gap = `roll_width + side_clearance` (2 mm). |
| `core_id` | 37.5 | Fin diameter = `core_id − 2 × core_clr` (0.4 mm per side). |
| `roll_od_max` | 80 | Axle height, bear-head size and the gap in front of the roll all scale with it. |
| `axle_clr` | 0.4 | Slot width = journal Ø10 + 0.4. |
| `snap_interf` | 0.5 | How hard the axle clicks in (about 6–7 N by beam estimate). Lower it if the axle is too stiff. |
| `peel_angle` | 45 | Peel-edge sharpness. 40–50 prints without supports. |
| `deck_len` | 34 | Length of the flat deck, which should be about one sticker. |
| `keeper_gap` | 2.6 | Height of the liner slot under the keeper bar's V. |
| `base_h`, `base_w`, `base_back`, `cheek_t` | 10, 84, 6, 5 | Base thickness and footprint, and cheek thickness. |
| `bay_w`, `bay_l`, `bay_depth` | 31, 78, 6 | Size of the weight bay. |
| `foot_d`, `foot_depth` | 10.5, 1 | Bumper-feet recesses. |

Every derived position (axle height, peel-edge position, guide bars) is computed from
these. The viewer reads the same numbers, so its animation stays in step with the CAD.

## Rebuilding and measuring

```sh
./build.sh                             # STL + 3MF + PNG previews + mesh checks + viewer + viewer check
SKIP_VIEWER_CHECK=1 ./build.sh         # skip the headless-browser step
uv run tools/slice_report.py --runs 2  # slice in Bambu Studio: time, grams, support (on/off)
uv run tools/overhangs.py              # any down-facing surface flatter than 45 degrees?
```

Requirements:

- OpenSCAD 2021.01 or later, at `/Applications/OpenSCAD.app` (override with
  `OPENSCAD=...`).
- Bambu Studio, for `slice_report.py`.
- [`uv`](https://docs.astral.sh/uv/). The Python tools carry their dependencies inline
  (PEP 723).
- For the viewer check only, a one-time install:
  `uv run --with playwright playwright install chromium-headless-shell`.

| File | Purpose |
|---|---|
| `sticker_dispenser.scad` | The parametric model. `part` = `base`, `axle`, `assembly` or `plate`. |
| `tools/slice_report.py` | Slices each part and the plate headless in Bambu Studio and reports print time, filament grams and support material. Every source is documented in the script. |
| `tools/support_tops.py` | Shows where in the model Bambu put support, from a sliced G-code. |
| `tools/overhangs.py` | Lists down-facing surfaces flatter than 45°. |
| `tools/make_3mf.py` | Builds the 3MFs from the STLs. OpenSCAD 2021's own 3MF writer produced a non-manifold part in round 1. |
| `tools/check_meshes.py` | Checks that every STL/3MF is watertight with consistent winding. |
| `tools/viewer_template.html`, `tools/build_viewer.py` | Build `out/viewer.html` with the STLs embedded. |
| `tools/check_viewer.py` | Loads the viewer in headless Chromium, fails on console errors, and saves `out/viewer_*.png`. |

## Verification (last run)

- **Slicing.** Every part and the full plate slice to 0 g of support with tree(auto) on.
  Filament and support grams are identical across repeat runs, and the print-time
  estimate varies by 7 s or less.
- **Overhangs.** No down-facing surface flatter than 45°, apart from the four 0.01 mm²
  cone tips over the foot recesses.
- **Meshes.** `base` and `axle` (STL and 3MF) are each a single watertight solid with
  consistent winding and positive volume. The plate 3MF holds 2 solid bodies.
- **Viewer.** It loads in headless Chromium with no console errors or warnings. The
  play/pause button, slider and toggles were all exercised. The one message filtered out
  is Chromium's "GPU stall due to ReadPixels" note, which the software renderer prints
  when taking screenshots.
- **Previews.**
  - OpenSCAD renders: `out/preview_assembly_front.png`, `out/preview_assembly_peel_edge.png`,
    `out/preview_print_plate.png`.
  - Viewer screenshots: `out/viewer_pulling.png`, `out/viewer_peeling.png`,
    `out/viewer_liner_path.png`.
- **Not checked.** The snap fit, the fit of the fins in a real core, and the peel action
  are untested until printed.
  - Snap fit: if it is too stiff, lower `snap_interf` to 0.3.
  - Fins: if they are tight in the core, raise `core_clr`.
  - Peel action: if stickers follow the liner around the edge instead of peeling, lower
    `peel_angle` to 40.
