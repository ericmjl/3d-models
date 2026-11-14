# Bear Buddy: a 3D-printable reward-chart token board

_Designed by Claude Code running Claude Opus 5.5 (`claude-opus-5-5`), Nov 14, 2026._

A small stand-up reward chart for a child. The board has 7 numbered cups in two rows
(4 at the bottom, 3 on top) and a bear head peeking over the top. It stands in two
bear-paw feet, leaning back 12 degrees. Each time the child earns a sticker, they take a
bear token out of the honey pot and drop it into the next empty cup, so they can see
their progress: 1, 2, 3 … 7, then reward time. It's the same bear theme as the Bear
Buddy sticker dispenser next door, in sky blue and yellow.

Every part prints with **zero support material**. The whole set fits on one X1 Carbon
plate and prints in **2 h 48 min (110 g of PLA)**.

![assembly](out/preview_assembly_front.png)
![all seven tokens placed](out/viewer_full.png)

Open **`out/viewer.html`** in a browser for an interactive 3D view. It animates the
tokens hopping out of the honey pot one by one into cups 1 to 7, followed by a little
celebration. It has play/pause, reset, a scrub slider and a show/hide-tokens toggle.
The page loads three.js from a CDN (unpkg), so it needs an internet connection. The STLs
are embedded, so it works straight from `file://`.

The viewer's **📦 Get the files** button (top right) lists the plate 3MF and every part
as 3MF and STL; the list is generated from whatever is in `out/`.
- **Phones.** Tapping a file opens the share sheet ("Open in…", Files, Bambu Handy…)
  through the Web Share API.
- **Elsewhere.** It downloads the file. From `file://`, the STLs are rebuilt from the
  geometry embedded in the page, and 3MFs fall back to a plain link.

## Parts

All parts are exported in print orientation. Times and grams are Bambu Studio estimates
for one copy (see "How the numbers were measured").

| File | What it is | Print orientation | Size (mm) | Bambu estimate |
|---|---|---|---|---|
| `out/board.stl` / `.3mf` | The token board: 7 numbered cups, a raised frame round the edge, and the bear head with raised eyes and snout | Flat on its back, face up, as exported | 210 × 130 × 8.1 | 1 h 13 min, 54.9 g |
| `out/foot.stl` / `.3mf` | Bear-paw foot (**print 2**). A slot that leans back holds the board's bottom edge. An open weight bay sits at the back, and three toes at the front | Standing, as exported | 36 × 66 × 13 | 15 min, 9.4 g each |
| `out/pot.stl` / `.3mf` | Honey pot that holds the unused tokens in a stack. It has beehive bands and a finger slot at the front | Standing, as exported | Ø 55 × 35 | 19 min, 14.1 g |
| `out/token.stl` / `.3mf` | Bear medallion token (**print 7**): a 46 mm round rim with a bear head on three spokes | Flat, face up, as exported | Ø 46 × 4.4 | 7 min 25 s, 3.4 g each |
| `out/token_board_plate.3mf` | Everything on one plate: board, 2 feet, honey pot, 7 tokens | Already laid out on the 256 × 256 mm bed | | **2 h 48 min 31 s, 110.5 g, 0 g support** |

The per-part times add up to more than the plate (1 h 13 + 2 × 15 + 19 + 7 × 7.4 ≈
3 h 14 min). Small parts printed alone pay the start-up routine and the minimum layer
time on every layer; printed together, those costs are shared.

Assembled, the board stands about 133 mm tall and 210 mm wide. The feet reach 66 mm
front to back.

## Print settings

- **Printer / process / filament:** Bambu Lab X1 Carbon, 0.4 mm nozzle, "0.20mm Standard
  @BBL X1C" exactly as shipped (2 walls, 15 % infill), Bambu PLA Basic.
- **Supports: off.** No part needs them. With supports switched on (tree/auto, 30°
  threshold), Bambu Studio still generates 0 g, so leaving them on does no harm either.
- **Plate:** open `out/token_board_plate.3mf` and print. The parts are already placed in
  bed coordinates and kept clear of the X1 Carbon's excluded front-left corner, so the
  file slices as laid out without re-arranging.
- **Colours:** board and feet in **sky blue**, tokens and honey pot in **yellow**.
  - **With an AMS:** assign the colours per object on the plate.
  - **With one spool:** print the single-part 3MFs in each colour. Use the "Plate" or
    "Arrange" tools in Bambu Studio to copy the feet ×2 and the token ×7.

## How to use it

1. Glue weights into the open bay at the back of each foot (see the safety note below).
2. Push the two feet onto the board's bottom edge, 51 mm either side of the centre:
   under the gap between cups 1 and 2, and under the gap between cups 3 and 4. There the
   cup rims are high enough for the foot's front lip. The toes point at the child and
   the board leans back into the slot.
3. Stack the 7 tokens in the honey pot and stand it beside the board.
4. Each time a sticker is earned, the child takes the top token (the finger slot at the
   front helps them slide the last few out) and drops it into the next empty cup,
   starting at 1 at the bottom left. The board leans back, so tokens rest in their cups.
5. When all 7 cups are full, it's reward time. Put the tokens back in the pot and start again.

## Safety notes

- **Glue the weights in.** Each foot has an open-top weight bay (23 × 34 × 11 mm,
  about 9 cm³) at its back. Fill it with steel washers, coins or steel shot, about 40–60 g
  per foot, and fix them with epoxy or plenty of hot glue so a child cannot pick them
  out. Loose washers and coins are a choking hazard. The bay is left open (not a
  sealed pocket) so it prints without supports.
- **Why weights help.** The whole set is light (about 110 g). A rough estimate from the
  part masses and centres of mass: a push of about 1.0 N (about 100 g of force) at the
  bottom row of cups tips the bare board backwards. With 40 g glued into each foot it
  takes about 1.6 N, and with 60 g about 1.8 N. Gentle token placing is fine; weights make it
  forgive a clumsy push.
- **No small parts.** The smallest loose part is a token, 46 mm across. That is well
  over the 31.7 mm small-parts test cylinder. The feet (36 × 66 mm) and the pot (Ø 55 mm) are
  bigger still. Check prints for sharp strings or burrs before handing them over, and
  supervise young children as with any toy.

## Design notes (zero supports, short print)

- **The board prints flat on its back.** Every feature (the frame, the cup rims, the
  bear's face) rises straight up from the bed, and the numbers are engraved into the
  top face, so nothing overhangs. Its floor is 1.6 mm: exactly the 3 bottom + 5 top solid
  layers of the stock profile. That leaves no sparse infill, so no slow bridge layer. The
  raised 6 mm frame and the cup rims stiffen it like a waffle, and they give the feet a
  6 mm edge to grip.
- **Feet:** the slot leans back 12°, so its front wall overhangs by only 12° from
  vertical. The front lip is narrow and low (6 mm), so it fits under the cup rims, and
  the toes are only 2 mm above the slot floor.
- **Honey pot:** each beehive band steps out at 56° from horizontal and steps back in
  facing upwards. The wall is a constant 1.6 mm (exactly 4 wall lines). The finger
  slot has a round, upward-facing bottom.
- **Tokens:** the open medallion was the quickest token design tried on the full plate
  (3 h 01 min against 3 h 04 min to 3 h 10 min for solid coins, in the same test). It keeps the
  full 46 mm round outline that the choking-hazard rule needs, and 4.4 mm is easy to pinch.
- `tools/overhangs.py` reports **0.0 mm²** of down-facing surface flatter than 45° on
  every part. Bambu Studio reports 0 g of support on every part and on the plate.
- An earlier version printed the board standing up, in one piece with a weighted base.
  It also needed no supports, but the plate took about 4 h 50 min, because
  every one of its ~800 layers paid for walls and travel across the 228 mm-wide panel.
  `OPTIMIZE_RESULTS.md` has the measurements behind every change.

## Parameters

All key dimensions are named parameters at the top of `token_board.scad`. They are
grouped as tokens, board, feet and honey pot. Examples: `n_tokens`, `token_d`,
`token_th`, `lean`, `floor_t`, `edge_t`, `rim_h`, `cup_clr`, `bottom_n`, `head_r`,
`foot_back`, `bay_*`, `pot_clr`, `pot_wall`. Cup spacing and row spacing are derived
from the token size, so the cups never clash.

```sh
./build.sh                    # STLs, 3MFs, plate, previews, viewer, mesh + overhang + viewer checks
./build.sh -D lean=15         # any parameter can be overridden
uv run tools/slice_report.py --runs 2 --json work/slice_report.json   # Bambu time / grams / support
```

Single parts: `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -D 'part="board"' -o out/board.stl token_board.scad`.
The parts are `board`, `foot`, `pot` and `token`; `assembly` and `plate` are previews only.

## How the numbers were measured

`tools/slice_report.py` slices headless with the Bambu Studio CLI
(`/Applications/BambuStudio.app/Contents/MacOS/BambuStudio`). It uses the system presets
"Bambu Lab X1 Carbon 0.4 nozzle", "0.20mm Standard @BBL X1C" and "Bambu PLA Basic @BBL
X1C", with their `inherits` chains flattened. Each part is sliced alone (auto-arranged).
The plate is sliced from `out/token_board_plate.3mf` exactly as laid out (no
re-arranging), and the script fails if Bambu needs more than one plate. Each is sliced
with supports **on** (tree/auto, 30° threshold, run twice) and with supports **off**.

- **Print time:** `result.json` → `total_predication`, the time the printer shows,
  including the start G-code. Cross-checked against the sliced 3MF's `prediction`.
- **Filament grams:** `result.json` → `total_used_g`. Cross-checked against the 3MF's
  `weight` and the G-code header.
- **Support grams:** the extrusion inside `; FEATURE: Support` / `Support interface` in the
  G-code, converted to grams. Cross-checked against Bambu's total minus model-only grams.

Results (2 runs with supports on, 1 with supports off). Grams and times were identical
across runs, and supports on and off gave the same numbers:

| Part | Print time | Filament | Support |
|---|---|---|---|
| board | 1 h 13 min 22 s | 54.86 g | 0.00 g |
| foot (each) | 15 min 29 s | 9.40 g | 0.00 g |
| pot | 18 min 54 s | 14.05 g | 0.00 g |
| token (each) | 7 min 25 s | 3.38 g | 0.00 g |
| **plate** (board, 2 feet, pot, 7 tokens) | **2 h 48 min 31 s** | **110.47 g** | **0.00 g** |

The full table, with the cross-checks, is in `work/slice_report.md` (raw rows in
`work/slice_report.json`).

## Files

- `token_board.scad`: the single parametric OpenSCAD source (`part=` selects a part).
- `build.sh`: rebuilds everything in `out/`.
- `tools/`: the sticker dispenser's tools, adapted. `slice_report.py` (Bambu slicing),
  `make_3mf.py` (per-part 3MFs, binary STLs, the plate), `check_meshes.py`,
  `overhangs.py`, `support_tops.py`, `build_viewer.py` + `viewer_template.html`, and
  `check_viewer.py` (headless browser check).
- `out/`: STLs, 3MFs, the plate 3MF, `viewer.html` and preview PNGs.
- `DIMENSIONS.md`, `OPTIMIZE_RESULTS.md`: working notes.
