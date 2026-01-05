#!/usr/bin/env bash
set -euo pipefail

# Change this if you want a different temporary directory
TMPDIR="$(mktemp -d)"
cd "$TMPDIR"

# Initialize git with main as default branch
git init -b main

# Create files with exact contents

cat > LICENSE <<'EOF'
MIT License

Copyright (c) 2026 lumin0sity-dev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

cat > .gitignore <<'EOF'
node_modules/
.DS_Store
dist/
.env
EOF

cat > README.md <<'EOF'
# Eagler — Voxel demo (1.20 inspired)

This repository contains a lightweight web demo inspired by Minecraft 1.20. The playable demo is located in the `play/` folder and can be served via GitHub Pages at:

https://lumin0sity-dev.github.io/eagler/play

Features:
- Procedural terrain generation (Simplex noise)
- Player movement (FPS-style)
- Block placing and breaking (raycast-based)
- Inventory UI and block selection
- Instanced rendering for improved performance
- Save / Load world JSON

How to run locally
1. Clone the repo
2. Serve the `play` folder with a static server (e.g., `npx http-server play -p 8080`)

License: MIT
EOF

cat > package.json <<'EOF'
{
  "name": "eagler",
  "version": "0.1.0",
  "description": "Web voxel demo inspired by Minecraft 1.20",
  "scripts": {
    "start": "npx http-server play -p 8080"
  },
  "dependencies": {
    "three": "^0.156.0",
    "simplex-noise": "^3.0.0"
  }
}
EOF

mkdir -p play/src

cat > play/index.html <<'EOF'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Eagler — Voxel Demo (1.20 inspired)</title>
  <link rel="stylesheet" href="styles.css" />
</head>
<body>
  <div id="ui">
    <div id="topbar">
      <button id="saveBtn">Save World</button>
      <input id="loadInput" type="file" accept=".json" style="display:none" />
      <button id="loadBtn">Load World</button>
      <span id="fps">FPS: --</span>
    </div>
    <div id="inventory"></div>
    <div id="help">Click to lock pointer. Left-click to break block, right-click to place block.</div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/three@0.156.0/build/three.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/three@0.156.0/examples/js/controls/OrbitControls.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/simplex-noise@3.0.0/dist/esm/simplex-noise.min.js"></script>
  <!-- App scripts -->
  <script src="src/world.js"></script>
  <script src="src/player.js"></script>
  <script src="src/input.js"></script>
  <script src="src/inventory.js"></script>
  <script src="src/save.js"></script>
  <script src="src/game.js"></script>
  <script src="src/main.js"></script>
</body>
</html>
EOF
