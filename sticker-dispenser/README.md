# Bear Buddy: a 3D-printable sticker-roll dispenser

A dispenser for a roll of round reward stickers (stickers on a paper liner wound on a
cardboard core). The roll spins on a snap-in axle. When you pull the liner tail, the
liner wraps sharply around a peel edge and the next sticker carries straight on and
lifts off, ready to grab. The side cheeks are bear heads, and the axle button is the
nose.

![assembly](out/preview_assembly_front.png)
![peel edge](out/viewer_peeling.png)

Open **`out/viewer.html`** in a browser for an interactive 3D view. It animates the roll
turning, the liner running over the peel edge, and a sticker lifting off. It has
play/pause, a scrub slider, a show/hide-roll toggle, and a see-through mode that shows
the liner path. The page loads three.js from a CDN (unpkg), so it needs an internet
connection. The STLs are embedded, so it works straight from `file://`.

## Parts

| File | What it is | Print orientation | Size |
|---|---|---|---|
| `out/base.stl` / `.3mf` | Base slab, both bear-head cheeks, peel deck, liner keeper bar and lower guide bar, in one piece | Flat on its bottom, as exported | 92 × 158 × 106 mm |
| `out/axle.stl` / `.3mf` | Axle with button ends; the journals snap into the cheek slots | Standing upright, as exported | Ø14 × 56 mm |
| `out/hub.stl` / `.3mf` | Spoked tube that fills the cardboard core; the roll and hub spin on the axle | Standing upright, as exported | Ø36.7 × 32 mm |
| `out/sticker_dispenser_plate.3mf` | All three parts laid out on one plate | | |

The base also has these features:

- **Underside.** Four Ø24.8 × 6 mm weight pockets, each holding 3 US quarters, 1-euro
  coins or 20 mm steel washers (fix them with a dab of hot glue or Blu-Tack). There are
  also four Ø10.5 × 1 mm recesses for stick-on silicone bumper feet. Use the feet: they
  stop the dispenser sliding when a child pulls the liner.
- **Decoration.** Debossed stars on the top, and a debossed bear face (eyes, blush,
  smile, inner ears) on both cheeks.

## Print settings (Bambu Studio / OrcaSlicer, PLA)

- **No supports needed.** I checked every down-facing surface steeper than 45°
  (`tools/overhangs.py`):
  - The only large ones are flat bridges: the keeper bar and the lower guide bar (each
    spans 35 mm), the coin-pocket ceilings (25 mm), and the foot recesses.
  - Everything else is under 25 mm², at the edges of the 1 mm-deep face decoration.
  - Bambu's default bridge settings handle these.
- **Layer height.** 0.2 mm. Use 0.16 mm if you want smoother bear ears.
- **Walls.** 3 walls on the base. Use 4 walls on the axle, or 100% infill, so the
  journals are solid.
- **Infill.** 15–20% gyroid on the base and hub. A denser base (30%+) adds weight, which
  helps it stay put.
- **Peel edge.** It is a 45° knife edge (`peel_angle`). Print it as it comes out; a
  slightly rounded 0.2–0.3 mm tip still peels well. Don't sand it blunt.
- **Bed adhesion.** No brim is needed for the base (large footprint) or the hub. Add a
  5 mm brim to the axle if your bed is slippery, since it is tall and narrow.
- **Colours.** In the previews the base is pink, the axle is blue and the hub is yellow.
  On an AMS you can also swap filament for the top layers to colour the face deboss.
- **Plastic use.** About 300 cm³ of solid volume, mostly the base. At the settings above
  that is very roughly 100–130 g of PLA in total.
- **Slicer check.** I did not slice the parts in Bambu Studio or Orca. The checks below
  are mesh-level only.

## Assembly and loading a roll

1. Slide the hub into the roll's cardboard core.
2. Push the axle through the hub. Either end works; the buttons are the same size as the
   middle section.
3. Thread the liner, stickers facing up:
   - over the deck and under the small keeper bar,
   - forward to the sharp front edge,
   - down behind the lower guide bar, then under it and out of the front of the base.

   The liner wraps about 125° around the peel edge. That sharp bend is what peels the
   sticker.
4. Drop the axle journals into the U-slots at the top of the bear heads and press down
   until they click past the snap bump.
5. To dispense, pull the liner tail forward or down. Lift the next sticker off the front
   edge.

To swap rolls, pull the axle up out of the slots. The flexible tine in each slot lets
it go.

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
| `roll_width` | 33 | Cheek gap = `roll_width + side_clearance` (2 mm). Hub length = `roll_width − 1`. |
| `core_id` | 37.5 | Hub OD = `core_id − 2 × core_clr` (0.4 mm per side). |
| `roll_od_max` | 80 | Axle height, bear-head size and the gap in front of the roll all scale with it. |
| `axle_clr` | 0.4 | Slot width = journal Ø10 + 0.4. Hub bore = Ø14 + 2 × 0.4. |
| `snap_interf` | 0.5 | How hard the axle clicks in. Lower it if the axle is too stiff. |
| `peel_angle` | 45 | Peel-edge sharpness. 40–50 prints without supports. |
| `deck_len` | 34 | Length of the flat deck, which should be about one sticker. |
| `keeper_gap` | 2.6 | Height of the liner slot under the keeper bar. |
| `base_h`, `base_w`, `coin_d`, `coin_depth`, `foot_d` | | Base heft, footprint, weight pockets and feet. |

Every derived position (axle height, peel-edge position, guide bars) is computed from
these. The viewer reads the same numbers, so its animation stays in step with the CAD.

## Rebuilding

```sh
./build.sh                       # STL + 3MF + PNG previews + mesh checks + viewer + viewer check
SKIP_VIEWER_CHECK=1 ./build.sh   # skip the headless-browser step
```

Requirements:

- OpenSCAD 2021.01 or later, at `/Applications/OpenSCAD.app` (override with
  `OPENSCAD=...`).
- [`uv`](https://docs.astral.sh/uv/). The Python tools carry their dependencies inline
  (PEP 723).
- For the viewer check only, a one-time install:
  `uv run --with playwright playwright install chromium-headless-shell`.

| File | Purpose |
|---|---|
| `sticker_dispenser.scad` | The parametric model. `part` = `base`, `axle`, `hub`, `assembly` or `plate`. |
| `tools/make_3mf.py` | Builds the 3MFs from the STLs. OpenSCAD 2021's own 3MF writer produced a non-manifold hub. |
| `tools/check_meshes.py` | Checks that every STL/3MF is watertight with consistent winding. |
| `tools/overhangs.py` | Lists down-facing surfaces steeper than 45°. |
| `tools/viewer_template.html`, `tools/build_viewer.py` | Build `out/viewer.html` with the STLs embedded. |
| `tools/check_viewer.py` | Loads the viewer in headless Chromium, fails on console errors, and saves `out/viewer_*.png`. |

## Verification (last run)

- **Meshes.** `base`, `axle` and `hub` (STL and 3MF) are each a single watertight solid
  with consistent winding and positive volume. The plate 3MF holds 3 solid bodies.
- **Viewer.** It loads in headless Chromium with no console errors or warnings. The
  play/pause button, slider and toggles were all exercised. The one message filtered out
  is Chromium's "GPU stall due to ReadPixels" note, which the software renderer prints
  when taking screenshots.
- **Previews.**
  - OpenSCAD renders: `out/preview_assembly_front.png`, `out/preview_assembly_peel_edge.png`,
    `out/preview_print_plate.png`.
  - Viewer screenshots: `out/viewer_pulling.png`, `out/viewer_peeling.png`,
    `out/viewer_liner_path.png`.
- **Not checked.** The snap fit and the peel action are untested until printed.
  - Snap fit: the axle should need a firm push (roughly 5–10 N) to click in. If it is
    too stiff, lower `snap_interf` to 0.3.
  - Peel action: if stickers follow the liner around the edge instead of peeling, lower
    `peel_angle` to 40.
