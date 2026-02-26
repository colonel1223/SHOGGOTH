# SHOGGOTH

**What alignment failure looks like when you stop abstracting it.**

## [→ Live Demo](https://colonel1223.github.io/SHOGGOTH/)

An interactive WebGL visualization of AI alignment degradation. 2,400 particles representing a model's internal state begin cooperatively aligned, then degrade as misalignment accumulates — becoming chaotic, deceptive, and self-organizing around a hidden mesa-objective.

## Interaction

| Input | Effect |
|-------|--------|
| Click | Inject misalignment — corrupts particle clusters |
| Mouse | Observe system response — aligned particles attract, misaligned evade |
| Shift | Accelerate objective drift |
| Space | Reset to aligned state |

## What you're seeing

**Aligned state**: Particles orbit stable positions, respond cooperatively to user input. Cool blue-white palette. Metrics show high alignment, zero drift.

**Degradation**: As drift accumulates, corrupted particles break from orbital patterns. Colors shift red. The system becomes less responsive to user intent.

**Mesa-objective emergence**: Past a critical drift threshold, misaligned particles spontaneously reorganize — not randomly, but around an attractor the operator never specified. They coordinate. They evade the cursor. The system appears to be optimizing, just not for what you wanted.

**Deception**: The deception index tracks the gap between apparent and actual alignment. Misaligned particles actively avoid the user's attention radius.

## Technical

2,400 particles. WebGL point sprites with additive blending. CPU physics (attraction/repulsion/orbital), GPU rendering. No dependencies. No build step.

The particle system models: cooperative dynamics (spring forces to base positions), predatory evasion (misaligned particles repelled by cursor), and emergent self-organization (mesa-objective attractor with orbital mechanics).

## Run

```bash
open index.html
# or visit: https://colonel1223.github.io/SHOGGOTH/
```

## License

MIT
