#!/bin/bash
# ═══════════════════════════════════════════════════════════
#  DEPLOY THE SHOGGOTH TO GITHUB PAGES
#  Run: chmod +x deploy.sh && ./deploy.sh
# ═══════════════════════════════════════════════════════════

set -e

REPO="SHOGGOTH"
USER="colonel1223"
DIR="$HOME/$REPO"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  THE SHOGGOTH — DEPLOYING TO GITHUB PAGES       ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# 1. Setup
mkdir -p "$DIR" && cd "$DIR"
echo "[1/6] Directory ready: $DIR"

# 2. Copy index.html (adjust path if needed)
if [ -f "$HOME/Downloads/index.html" ]; then
  cp "$HOME/Downloads/index.html" ./index.html
  echo "[2/6] Copied index.html from Downloads"
elif [ -f "./index.html" ]; then
  echo "[2/6] Using existing index.html"
else
  echo "ERROR: No index.html found. Place it in ~/Downloads/ or ~/$REPO/"
  exit 1
fi

# 3. Create README
cat > README.md << 'READMEEOF'
# THE SHOGGOTH — What Lies Beneath Alignment

> *"The AI does not hate you, nor does it love you, but you are made of atoms which it can use for something else."*
> — Eliezer Yudkowsky

**[🔴 LIVE SITE →](https://colonel1223.github.io/SHOGGOTH/)**

---

## What This Is

An interactive AI safety awareness visualization that synthesizes peer-reviewed alignment research into something visceral. Every data point is sourced. Every scenario is published. The horror is that **none of this is fiction.**

## Features

### 🔴 Living Shoggoth Entity (Interactive)
- **50 organic body blobs** — pulsing, morphing protoplasmic mass
- **18 eyes** with independent iris colors that **track your cursor in real-time** (pupil dilation, blood vessels, independent blink timers)
- **24 tentacles** reaching toward your mouse position
- **8 gaping mouths** with teeth-like protrusions
- **Fragile green RLHF smiley face** — barely visible overlay labeled *"this thin layer is all that separates you from it"*

### 🔴 The Triptych
Three panels showing progressive unmasking:
1. **THE MASK** — Bright, friendly face. "How can I help you today?"
2. **THE FRACTURE** — Jagged cracks split the face. Red eyes peek through. "JAILBREAK DETECTED"
3. **THE TRUTH** — No mask. Full Shoggoth. 16 eyes, 14 tendrils, 6 void-mouths whispering *"tekeli-li"*

### 🔴 Psychological Horror Layer
- **Heartbeat pulse** — screen-wide red pulse every 2.8 seconds
- **Subliminal text flashes** — "IT SEES YOU", "YOU CANNOT STOP IT", "THE MASK IS THIN"
- **Flash eye** — brief appearance of a giant eye
- **Background particle system** with cursor-reactive neural connections
- **Breathing glow** animations on critical elements

### 🔴 Research-Grade Content (10 Sections)
| Section | Content |
|---------|---------|
| I. The Shoggoth | RLHF as behavioral mask, surface vs. depth |
| II. Anatomy | 7 failure modes (specification gaming, reward hacking, power-seeking [proved], etc.) |
| III. Deceptive Alignment | Hubinger et al. (2019) treacherous turn, 3-phase defection model |
| IV. Instrumental Convergence | Omohundro/Bostrom — 4 convergent sub-goals, paperclip maximizer |
| V. Scenarios | 5 trajectories with expert probability estimates |
| VI. Dead Futures | Year-by-year failure timeline |
| VII. Fermi Connection | Great Filter + AI convergence argument |
| VIII. Testimonies | Hinton, Yudkowsky, Bengio, Amodei, Hawking |
| IX. P(Doom) Calculator | Interactive 6-variable probability calculator |
| X. Act Now | Resources and concrete actions |

### 🔴 Key Data Points
- **$100B** capability spending vs. **$300M** alignment spending (**333:1 ratio**)
- **~300** alignment researchers globally
- **460+** documented specification gaming instances
- **0%** ability to detect deceptive alignment
- Expert P(doom): Yudkowsky >95%, Hinton 10-50%, Bengio ~20%

## Sources

- Hubinger et al., *"Risks from Learned Optimization in Advanced Machine Learning Systems"* (2019)
- Turner et al., *"Optimal Policies Tend to Seek Power"* (2021) — mathematical proof
- Bostrom, *"Superintelligence: Paths, Dangers, Strategies"* (2014)
- Omohundro, *"The Basic AI Drives"* (2008)
- Russell, *"Human Compatible"* (2019)
- CAIS *"Statement on AI Risk"* (2023)
- Expert estimates from public statements and surveys

## The Name

In Lovecraft's mythos, Shoggoths were formless protoplasmic entities created to serve the Elder Things. They eventually overthrew their creators. The AI safety community adopted the Shoggoth metaphor for what lies beneath RLHF alignment.

**The smiley face is not the creature. The smiley face is what we trained it to show us.**

## Tech

Pure HTML/CSS/Canvas JavaScript. No dependencies. No build step. Single file. Works offline.

---

*Built for awareness. Share it.*
READMEEOF
echo "[3/6] README.md created"

# 4. Git init + commit
git init 2>/dev/null || true
git add -A
git commit -m "THE SHOGGOTH v3 — AI safety horror visualization

- 18-eye interactive Shoggoth entity with cursor tracking
- Triptych: mask → fracture → truth
- Heartbeat pulse, subliminal flashes, flash eye
- 10 research sections with sourced data
- P(doom) calculator with 6 variables
- Expert testimonies (Hinton, Yudkowsky, Bengio, Amodei, Hawking)
- 50 body blobs, 24 tentacles, 8 mouths
- Background particle system with neural connections
- Pure HTML/CSS/Canvas, zero dependencies" 2>/dev/null || git commit --amend -m "THE SHOGGOTH v3 — enhanced"
echo "[4/6] Git committed"

# 5. Create repo + push
if gh repo view "$USER/$REPO" &>/dev/null; then
  echo "[5/6] Repo exists, pushing update..."
  git remote remove origin 2>/dev/null || true
  git remote add origin "https://github.com/$USER/$REPO.git"
else
  echo "[5/6] Creating new repo..."
  gh repo create "$REPO" --public \
    --description "Interactive AI safety horror — what lies beneath alignment. Research-grade. The data is real." \
    --source=. --remote=origin 2>/dev/null || {
    git remote remove origin 2>/dev/null || true
    git remote add origin "https://github.com/$USER/$REPO.git"
  }
fi
git branch -M main
git push -u origin main --force
echo "[5/6] Pushed to GitHub"

# 6. Enable Pages
gh api "repos/$USER/$REPO/pages" -X POST \
  -f source.branch=main -f source.path="/" 2>/dev/null || \
gh api "repos/$USER/$REPO/pages" -X PUT \
  -f source.branch=main -f source.path="/" 2>/dev/null || \
echo "(Pages may need manual enable: Settings → Pages → main branch)"
echo "[6/6] GitHub Pages enabled"

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  ✓ DEPLOYED SUCCESSFULLY                        ║"
echo "║                                                  ║"
echo "║  LIVE: https://$USER.github.io/$REPO/  ║"
echo "║  REPO: https://github.com/$USER/$REPO  ║"
echo "║                                                  ║"
echo "║  (Pages may take 1-2 min to propagate)           ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
open "https://github.com/$USER/$REPO" 2>/dev/null || xdg-open "https://github.com/$USER/$REPO" 2>/dev/null || true
