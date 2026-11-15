# Bear Buddy and Bunny Buddy: 3D-printable reward-chart token boards

_Designed by Claude Code running Claude Opus 5.5 (`claude-opus-5-5`), Nov 14, 2026._

One design, two themes, built from the same `token_board.scad`:

| | Bear Buddy (Philip's board) | Bunny Buddy (Deborah's board) |
|---|---|---|
| Files | `out/` | `out/bunny/` |
| Board top | bear head, round ears | bunny head, tall ears |
| Tokens | bear-face medallions | bunny-face medallions |
| Feet | bear paws, round toes | bunny paws, long oval toes |
| Token holder | beehive honey pot | carrot pot (carrot rings, leafy top) |
| Colours | sky blue + yellow | lavender + white |
| Plate | **2 h 48 min, 110.5 g, 0 g support** | **3 h 01 min, 113.3 g, 0 g support** |

The bear is Philip's board and the bunny is Deborah's. The printed parts carry no
names or initials, so either board suits any child. The cups, tokens, feet, slot,
weight bays and pot interior are identical in both, so tokens and feet even swap between
them. Only the decoration differs. The bear is described first; the bunny section
below lists what changes.

## Bear Buddy (Philip)

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

### Bear parts

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

## Bunny Buddy (Deborah)

![bunny assembly](out/bunny/preview_assembly_front.png)
![bunny: all seven tokens placed](out/bunny/viewer_full.png)

The same board with a bunny on top. The bunny head has two tall ears (the board is
160 mm long instead of 130, about 162 mm tall when standing). The tokens are
bunny-face medallions, the feet have long bunny toes, and the unused tokens live in a
carrot pot: finer carrot rings round the outside and a crown of three carrot leaves at
the back of the rim, away from the finger slot. Interactive viewer:
**`out/bunny/viewer.html`**. It's titled for Deborah and works the same way as the bear's
viewer (tokens hop from the carrot pot into cups 1 to 7, play/pause, reset, scrub
slider, show/hide tokens, and the **📦 Get the files** panel listing the bunny files).

**Zero supports, ears included.** The tall ears are a flat outline in the plane of the
board, like the bear's head, so they lie flat on the bed and rise straight up 6 mm with
the frame round them; the recessed middle of each ear reads as the inner ear. Nothing
leans or hangs. The carrot leaves continue the pot's 1.6 mm wall straight up, and each
leaf narrows towards its tip, so no edge faces downwards. `tools/overhangs.py` reports
**0.0 mm²** flatter than 45° on every bunny part, and Bambu Studio reports **0.00 g** of
support on every part and on the plate.

| File (all in `out/bunny/`) | What it is | Print orientation | Size (mm) | Bambu estimate |
|---|---|---|---|---|
| `board.stl` / `.3mf` | Token board with the bunny head and tall ears | Flat on its back, face up | 210 × 160 × 8.1 | 1 h 17 min, 57.2 g |
| `foot.stl` / `.3mf` | Bunny-paw foot (**print 2**): same slot and open weight bay, long oval toes | Standing | 36 × 68 × 13 | 15 min, 9.5 g each |
| `pot.stl` / `.3mf` | Carrot pot for the unused tokens, finger slot at the front, leaves at the back | Standing | Ø 54 × 47 (35 to the rim) | 22 min, 14.4 g |
| `token.stl` / `.3mf` | Bunny medallion token (**print 7**); the ear tips run into the rim | Flat, face up | Ø 46 × 4.4 | 8 min, 3.4 g each |
| `token_board_plate.3mf` | Everything on one plate | Already laid out on the bed | | **3 h 00 min 36 s, 113.3 g, 0 g support** |

The bunny plate takes 12 min longer than the bear's. The carrot leaves make the pot
12 mm taller, the bunny token has two more small pits (the inner ears), and the ears
add board area. A test with shorter leaves and no inner ears saved only 4 min, so the
full bunny was kept. The taller board leaves no room for the bear's two neat rows of
parts, so `tools/make_3mf.py` packs the bunny plate around the ears instead. It still
keeps every part 5 mm apart and out of the bed's excluded corner.

**Colours:** board and feet in **lavender** (any lilac/lavender PLA), tokens and carrot
pot in **white**. The viewer uses the same colours. Print settings, assembly, weights
and safety notes are the same as for the bear (below). The bunny tips at the same push
as the bear: about 1.1 N bare and 1.6 N with 40 g per foot. One extra note: the carrot
leaves are 1.6 mm thick. They are joined in a band along the rim, but check them after
printing, and don't hand over a pot with a chipped leaf.

## Print settings (both boards)

- **Printer / process / filament:** Bambu Lab X1 Carbon, 0.4 mm nozzle, "0.20mm Standard
  @BBL X1C" exactly as shipped (2 walls, 15 % infill), Bambu PLA Basic.
- **Supports: off.** No part needs them. With supports switched on (tree/auto, 30°
  threshold), Bambu Studio still generates 0 g, so leaving them on does no harm either.
- **Plate:** open `out/token_board_plate.3mf` (bear) or `out/bunny/token_board_plate.3mf` (bunny) and print. The parts are already placed in
  bed coordinates and kept clear of the X1 Carbon's excluded front-left corner, so the
  file slices as laid out without re-arranging.
- **Colours:** bear: board and feet in **sky blue**, tokens and honey pot in **yellow**.
  Bunny: board and feet in **lavender**, tokens and carrot pot in **white**.
  - **With an AMS:** assign the colours per object on the plate.
  - **With one spool:** print the single-part 3MFs in each colour. Use the "Plate" or
    "Arrange" tools in Bambu Studio to copy the feet ×2 and the token ×7.

## How to use it (both boards)

1. Glue weights into the open bay at the back of each foot (see the safety note below).
2. Push the two feet onto the board's bottom edge, 51 mm either side of the centre:
   under the gap between cups 1 and 2, and under the gap between cups 3 and 4. There the
   cup rims are high enough for the foot's front lip. The toes point at the child and
   the board leans back into the slot.
3. Stack the 7 tokens in the pot (honey pot or carrot pot) and stand it beside the board.
4. Each time a sticker is earned, the child takes the top token (the finger slot at the
   front helps them slide the last few out) and drops it into the next empty cup,
   starting at 1 at the bottom left. The board leans back, so tokens rest in their cups.
5. When all 7 cups are full, it's reward time. Put the tokens back in the pot and start again.

## Safety notes (both boards)

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

## Parameters and themes

All key dimensions are named parameters at the top of `token_board.scad`. They are
grouped as tokens, board, feet and pot. `theme = "bear"` (the default) or `"bunny"`
picks the decoration. The bunny's shapes have their own parameters (`bun_head_r`,
`bun_ear_rx`, `bun_ear_ry`, `bun_ear_tilt`, `bun_toe_long`, `carrot_bands`, `leaf_h`, …).
Everything mechanical is shared. Examples: `n_tokens`, `token_d`,
`token_th`, `lean`, `floor_t`, `edge_t`, `rim_h`, `cup_clr`, `bottom_n`, `head_r`,
`foot_back`, `bay_*`, `pot_clr`, `pot_wall`. Cup spacing and row spacing are derived
from the token size, so the cups never clash.

```sh
./build.sh                    # bear into out/: STLs, 3MFs, plate, previews, viewer, all checks
./build.sh bunny              # bunny into out/bunny/
./build.sh bunny -D lean=15   # any parameter can be overridden
OUT_DIR=work/test ./build.sh  # build somewhere else (leaves out/ alone)
uv run tools/slice_report.py --runs 2 --json work/slice_report.json                        # bear
uv run tools/slice_report.py --theme bunny --runs 2 --json work/slice_report_bunny.json    # bunny
```

The tools take the folder too: `make_3mf.py --out-dir`, `build_viewer.py --theme
bunny`, `check_meshes.py out/bunny`, `overhangs.py out/bunny`, `check_viewer.py out/bunny`.

Single parts: `/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD -D 'theme="bunny"' -D 'part="board"' -o out/bunny/board.stl token_board.scad`
(leave out `theme` for the bear).
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

**Bear** results (2 runs with supports on, 1 with supports off). Grams and times were
identical across runs, and supports on and off gave the same numbers:

| Part | Print time | Filament | Support |
|---|---|---|---|
| board | 1 h 13 min 22 s | 54.86 g | 0.00 g |
| foot (each) | 15 min 29 s | 9.40 g | 0.00 g |
| pot | 18 min 54 s | 14.05 g | 0.00 g |
| token (each) | 7 min 25 s | 3.38 g | 0.00 g |
| **plate** (board, 2 feet, pot, 7 tokens) | **2 h 48 min 31 s** | **110.47 g** | **0.00 g** |

The full table, with the cross-checks, is in `work/slice_report.md` (raw rows in
`work/slice_report.json`).

**Bunny** results (`--theme bunny`, files in `out/bunny/`; 2 runs with supports on, 1 with
supports off). Grams were identical across runs and across supports on/off, except the
board: with supports off Bambu reports 57.33 g instead of 57.24 g, still with 0 g of
support. Times varied by at most 2 s:

| Part | Print time | Filament | Support |
|---|---|---|---|
| board | 1 h 17 min 18 s | 57.24 g | 0.00 g |
| foot (each) | 15 min 16 s | 9.47 g | 0.00 g |
| pot (carrot) | 22 min 24 s | 14.39 g | 0.00 g |
| token (each) | 8 min 06 s | 3.38 g | 0.00 g |
| **plate** (board, 2 feet, pot, 7 tokens) | **3 h 00 min 36 s** | **113.25 g** | **0.00 g** |

Full table: `work/slice_report_bunny.md` (raw rows in `work/slice_report_bunny.json`).

Adding the theme did not change the bear. The bear files in `out/` were not regenerated
(their checksums match those taken before the bunny work). A fresh bear build from the
themed SCAD (`OUT_DIR=work/bearbuild ./build.sh`) produces exactly the same triangles,
and its plate slices to the same 110.47 g.

## Files

- `token_board.scad`: the single parametric OpenSCAD source (`part=` selects a part,
  `theme=` the bear or the bunny).
- `build.sh`: rebuilds everything for one theme (bear into `out/`, bunny into `out/bunny/`).
- `tools/`: the sticker dispenser's tools, adapted. `slice_report.py` (Bambu slicing),
  `make_3mf.py` (per-part 3MFs, binary STLs, the plate), `check_meshes.py`,
  `overhangs.py`, `support_tops.py`, `build_viewer.py` + `viewer_template.html`, and
  `check_viewer.py` (headless browser check).
- `out/`: the bear's STLs, 3MFs, plate 3MF, `viewer.html` and preview PNGs.
- `out/bunny/`: the same set for the bunny.
- `DIMENSIONS.md`, `OPTIMIZE_RESULTS.md`: working notes.
