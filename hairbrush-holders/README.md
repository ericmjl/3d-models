# Cat and bunny brush holders

_Designed by a Cursor cloud agent running Grok 4.7 High Fast, Nov 14, 2026._

Two single-brush wall holders, one for each brush Eric measured. The cat holds
the paddle brush. The bunny holds the pink detangling brush. Each is the same
cradle as the two-brush hook next door: the neck slides down an open channel,
the wider head rests on two shoulders, and 45° lips keep the handle from
falling forward. The channel is open at the bottom, so a long handle hangs
through.

The back plate is a Hello Kitty-style face, for personal use, and the two
faces are mirror-symmetric. Both share one wide, soft head, a little wider
than it is tall, with small oval eyes, an outlined oval nose, no mouth, and
three whiskers a side. The cat has short rounded ears and a bow centered
between them. The bunny is the same face with two long upright ears, lines
inside the ears, and the bow on the forehead. It prints flat on its back
(the wall face is on the bed) in two colours: a white body, and a black
outline plus the eyes, nose, whiskers, bow, and the bunny's inner ears. The
black is the top 0.8 mm of the plate, in a recess, so it needs no supports.
Open the viewer for that holder to orbit it with a translucent ghost of the
brush seated in the cradle.

| | Cat | Bunny |
|---|---|---|
| Viewer | [`cat/out/viewer.html`](cat/out/viewer.html) | [`bunny/out/viewer.html`](bunny/out/viewer.html) |
| Brush | paddle | pink detangler |
| Print | **2 h 13 min, 96.4 g, 0 g support** | **2 h 15 min, 96.0 g, 0 g support** |

The page loads three.js from unpkg. The STLs are embedded, so the model and
the STL buttons still work from `file://`. **📦 Get the files** uses the Web
Share API ("Open in…") on a phone, and downloads the file where that API is
missing. A 3MF opened from `file://` falls back to a plain link. GitHub Pages
serves the files over HTTP.

## Measured, assumed, and what the slot became

The photos and the ruler notes are approximate. Every number below is a
variable in `hairbrush_holder.scad`. `clr_side` and `clr_t` are 1.5 mm of
clearance on top of the neck measurement (1.5 mm each side of the width, and
1.5 mm in front of the thickness).

Neck thickness was not in the notes or the photos. The slot depth uses the
grip thickness, which is the thicker, safer guess. If the real neck is
thinner, the brush still sits; if it is thicker, raise `cat_neck_t` or
`bun_neck_t`.

| | Cat, paddle | | Bunny, pink brush | |
|---|---|---|---|---|
| | Measured | In the model | Measured | In the model |
| Overall length | about 250 mm | 250 | about 240 mm | 240 |
| Head width | about 95 | 95 | about 75 | 75 |
| Head length | about 135 | 135 | about 120 | 120 |
| Head thickness, with bristles | about 35 | 35 | about 30, estimated | 30 |
| Cushion, without bristles | about 20 | 20 | not measured | 16, assumed |
| Neck width, just under the head | about 25 | 25 | about 30 | 30 |
| Neck thickness | not measured | 20, assumed from the grip | not measured | 15, assumed from the grip |
| Grip width | about 30 | 30 | about 32 | 32 |
| Grip thickness | about 20, estimated | 20 | about 15, estimated | 15 |
| **Slot the neck slides into** | | **28.0 × 21.5 mm, 17 mm between the lips** | | **33.0 × 16.5 mm, 22 mm between the lips** |
| Plate | | 230 × 204 × 33 mm | | 230 × 236 × 28 mm |

The cat's 30 mm grip is wider than the 28 mm slot. The grip hangs below the
lips; you push the neck in from the front, at the open mouth, then slide down.
You do not thread the grip up through the channel. The bunny's grip is 32 mm
and the slot is 33 mm, so that handle can hang inside the channel width.

A neck from about 21 to 25 mm is held in the cat (the opening is 17 mm). A
neck from about 26 to 30 mm is held in the bunny (the opening is 22 mm). The
head has to stay wider than the slot. The neck should stay about that wide
for the 32 mm the lips capture.

## How to change a number

`theme` is `"cat"` or `"bunny"`. The brush blocks at the top of
`hairbrush_holder.scad` are the measurements. `part` selects what you export:

```bash
openscad -D 'theme="cat"'   -D 'part="white"' -o cat/out/white.stl   hairbrush_holder.scad
openscad -D 'theme="cat"'   -D 'part="black"' -o cat/out/black.stl   hairbrush_holder.scad
openscad -D 'theme="bunny"' -D 'part="white"' -o bunny/out/white.stl hairbrush_holder.scad
openscad -D 'theme="bunny"' -D 'part="black"' -o bunny/out/black.stl hairbrush_holder.scad
```

`part = "assembly"` (the default when you open the file) shows both colours
and a ghost brush. The committed STL, 3MF and viewer match the tables above.
After you change a number that affects the solid, re-export both colours. The
ghosts in the viewers are drawn by three.js from these same numbers.

One neck at a time, for a first fit check:

```bash
openscad -D 'theme="cat"' -D 'part="white"' -D 'cat_neck_w=27' -D 'cat_neck_t=18' \
  -o cat/out/white.stl hairbrush_holder.scad
```

## How a brush goes in

Bristles face out. The back of the handle sits against the plate.

1. Push the neck into the open mouth just under the shoulders.
2. Slide it down until the head rests on the two shoulders.
3. Lift about 32 mm and pull forward to take it out.

The ears stand clear of the brush, and the eyes and whiskers sit wide, beside
the head, so each face still reads with the brush hanging. The nose and the
bow are in the middle. The brush covers them while the brush is in. On the
bunny, the outer loops of the bow still peek out beside the narrower head.

## Mounting

**Screws.** Four countersunk holes, M4 or a #8 flat head (4.5 mm hole, 8.8 mm
90° countersink, opening toward the front of the print). Two in the chin, two
in the forehead. The plate is 4.6 mm thick. Use a screw into a stud or a
proper anchor, and don't overtighten PLA.

**Command strips.** Each cheek has an engraved outline for a medium 3M Command
picture-hanging strip (19 × 70 mm; the engraved box is 19 × 64 mm and sits
inside the silhouette). Two pairs of medium strips are rated to 2.5 kg. The
engraving is on the front. The adhesive goes on the flat back, in that same
spot, clear of the screw holes.

The back face is the face that was on the bed. Textured PEI is a poor surface
for Command adhesive. Print this on the smooth plate, or sand the back and
wipe it with isopropyl alcohol before you stick the strips.

## Print

| | |
|---|---|
| Printer | Bambu Lab X1 Carbon, 0.4 mm nozzle, AMS |
| Filament | Bambu PLA Basic, filament 1 white, filament 2 black |
| Layer height | 0.20 mm, 2 walls, 15% infill (0.20 mm Standard @BBL X1C) |
| Supports | Off. The slice made 0 g |
| Orientation | Back face on the bed. The 3MF is already placed on the plate |

Sliced with OrcaSlicer 2.5.1. The two colours are one assembled object, so
Bambu Studio opens the 3MF with white on filament 1 and black on filament 2.
The black is only the top of the plate, so the colour changes are four layers
near the end of the plate (four changes). The prime tower is off: the
silhouette already fills most of the 256 mm bed. Orca still counts a small
flush at each change. An automatic brim is included in the totals below; the
footprint is large enough to print with the brim turned off.

| | Cat | Bunny |
|---|---|---|
| Model printing time | 2 h 5 m 48 s | 2 h 7 m 44 s |
| Total estimated time | 2 h 13 m 4 s | 2 h 15 m 0 s |
| White, including flush | 93.2 g | 92.2 g |
| Black, including flush | 3.2 g | 3.8 g |
| Total filament | 96.4 g | 96.0 g |
| Of which, brim | 2.6 g | 2.8 g |
| Support | 0 g | 0 g |
| Layers | 167, 33.4 mm tall | 142, 28.4 mm tall |

The white mesh has no down-facing surface flatter than 45° except the bed.
The lip undersides are exactly 45°. The black skin sits in a pocket in the
white plate, so its underside is carried by the white.

`cat/out/cat_holder.3mf` and `bunny/out/bunny_holder.3mf` are shifted onto the
bed (centred around X = 128 mm, the chin near the front). The per-colour STLs
stay in part coordinates, for arranging a plate yourself. Load both STLs and
assign white and black, or just open the 3MF.

## Files

| File | What it is |
|---|---|
| `hairbrush_holder.scad` | Both holders. `theme` picks the cat or the bunny |
| `cat/out/white.stl`, `black.stl` | Cat body and cat face |
| `cat/out/cat_holder.3mf` | Both, filaments assigned, placed on the bed |
| `cat/out/viewer.html` | White, black, and the paddle ghost |
| `bunny/out/white.stl`, `black.stl` | Bunny body and bunny face |
| `bunny/out/bunny_holder.3mf` | Both, filaments assigned, placed on the bed |
| `bunny/out/viewer.html` | White, black, and the pink ghost |

## Untested

Nothing here has been printed.

- The real necks. Thickness was assumed from the grip, and every other
  measurement was read off a ruler in a photo.
- Whether the cat's wider grip starts inside the 32 mm the lips capture. If
  it does, lower `retain_h`.
- Command-strip adhesion on a textured PEI back. Use the smooth plate, or
  sand and wipe the back.
- How the screws hold in a particular wall. The holes are clearance holes.
- A purge tower. The estimate flushes at the colour changes and does not grow
  a tower, because the part leaves little free bed.
