# Mo God Mo Love

Faith-inspired fashion by Monique Lovelace. Single-page storefront for the
*Product of God's Grace* and *I Am Fearfully and Wonderfully Made* blazers.

Everything is in `index.html` — one self-contained file, no build step. That
is deliberate: it can be dropped into a GoHighLevel custom-code block or
served as a static site unchanged.

## Products

| Piece | Status | Price | Colors | Sizes |
|---|---|---|---|---|
| Product of God's Grace | In stock | $68 + shipping | Black only | S–2X |
| I Am Fearfully & Wonderfully Made | Coming soon | TBD | Maroon, black | M–3X |

Psalm 139:14 is embroidered on the cuff of the *Fearfully* blazer.

## Running it locally

    python3 -m http.server 8000
    # then open http://localhost:8000

Open it through a server, not by double-clicking the file.

## Animation

Loaded from CDN, with a working fallback if either fails:

- **Lenis** — momentum smooth scrolling
- **GSAP + ScrollTrigger** — pinning, scrubbing, the horizontal lookbook

If the CDNs are blocked or slow, the page falls back to IntersectionObserver
reveals and stays fully usable. That path is tested — don't remove it.

`prefers-reduced-motion` is honored throughout.

## Assets

`assets/img/` holds web-optimized copies (originals were 23MB, these are
~4MB). `logo-mark.png` and `logo-lockup.png` have had their white
backgrounds flood-filled to transparency so they sit on dark.

## The 360 spin — shoot spec

The viewer is built and wired; it stays hidden until frames exist. It is
photography, not 3D, so it shows the real garment.

**To shoot it:**

1. Put the blazer on the dress form. Mark the form's base and the floor so
   you can rotate it in even steps and it returns to the same spot.
2. Put the camera on a tripod. **Do not move it between frames** — not one
   inch. Lock focus and exposure (no auto, or the brightness will jump).
3. Plain, evenly lit background. The cream seamless from the studio shots is
   ideal. Avoid harsh side light that shifts as the garment turns.
4. Rotate the form **15° per frame for 24 frames**, or 10° for 36. More
   frames is smoother; 24 is plenty.
5. Shoot the *Product of God's Grace* blazer first — it's the one in stock.

**Then:** drop the images into `assets/spin/` named `01.jpg`, `02.jpg`, … and
list them in `SPIN_FRAMES` near the top of the script block in `index.html`.
The section unhides itself. Budget ~400KB total, so resize to about 900px
wide before committing.

## Taking orders

Set `ORDER_ENDPOINT` in the script block at the bottom of `index.html`. Until
it has a value the form opens a pre-filled email to
lovelacemonique@icloud.com, so an order is never silently dropped.

Two delivery modes, picked automatically from the URL:

**GoHighLevel (or Zapier / Make) webhook** — posts JSON. These endpoints
usually send no CORS headers, so the browser will not let the page read the
reply. The request goes through, but the page cannot tell success from
failure and always reports success. **Send one real test reservation and
confirm it lands in the CRM before trusting it.**

Note the browser forces the request to `text/plain` under `no-cors` no matter
what header is set. The body is still valid JSON and GHL parses it fine.

**Formspree / Basin / Web3Forms** — posts form data, reads the reply, and
reports real success or failure. Use this if you want the page to actually
know whether it worked.

Fields sent: `name`, `phone`, `email`, `piece`, `size`, `notes`, plus
`source` and `submittedAt`.

A hidden `company` honeypot field catches bots. If it is filled the page shows
the normal thank-you and sends nothing, so the bot gets no signal.

No payment is taken on the page. Monique confirms each order, then settles by
Cash, Zelle, CashApp, PayPal or Apple Pay.

## Before launch — REMOVE THESE

The preview is deliberately hidden from search engines so it cannot outrank
`mogodmolove.shop` for the brand's own name. The day the real domain goes
live, do both of these or the real site will stay invisible to Google:

1. Delete the `<meta name="robots" content="noindex, nofollow">` line in
   `index.html` (it sits just under the `theme-color` meta).
2. Delete `robots.txt`.

## Deploying

Static hosting works as-is (GitHub Pages, Netlify, Cloudflare Pages).

If it goes into GoHighLevel, use a **custom code element**, not an HTML
iframe embed — an iframe sandboxes the page and the scroll animations break,
because elements only see the iframe's viewport.

**Do not cancel the Wix subscription until `mogodmolove.shop` has been
repointed and verified serving from the new host.** The domain currently
resolves to Wix.
