# Vendored libraries

Self-hosted rather than loaded from a CDN, so the site does not depend on a
third party being up and so what gets tested is what ships.

| File | Package | Version | Licence |
|---|---|---|---|
| `lenis.min.js` | lenis | 1.1.18 | MIT — see `LICENSE-lenis.txt` |
| `gsap.min.js` | gsap | 3.12.5 | GreenSock Standard "no charge" licence |
| `ScrollTrigger.min.js` | gsap | 3.12.5 | GreenSock Standard "no charge" licence |

GSAP's standard licence covers sites like this one, where the code is not
sold or offered as part of a product people pay to access:
https://gsap.com/standard-license

To update, take the files from the npm packages of the same names and change
the versions above. The page still falls back to IntersectionObserver reveals
if these fail to load — keep that path working.
