# Sky Dodge

A compact Godot 4 arcade game made by vaibhav sharma  Steer the glider through falling hazards and survive as long as possible.

## Project layout

- `assets/art` — a four-frame SVG bird flight sheet, cloud, meteor, and spike-orb art
- `assets/audio` — reusable procedural music plus flap, crash, and game-over effects
- `assets/fonts` — project font resource
- `scenes` — Main, Player, and Obstacle scenes
- `scripts` — gameplay scripts

## Run

1. Import this folder in Godot 4.
2. Press **F5** to play.

## Publishing

Export an HTML5 build from Godot using **Project → Export**. Create a **Web** preset, export it into `builds/web/`, then zip the contents of that folder for itch.io. In itch.io, create a new HTML game, upload that zip, and enable **This file will be played in the browser**.

## Controls

- **A/D** or **Left/Right Arrow** — steer
- **R** or **Space** — restart after a crash
