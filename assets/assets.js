/*
 * Asset manifest — the ONLY place image sources live.
 *
 * Every slot below is a named position in the page. To swap a photo, change one
 * line here; nothing in index.html needs touching.
 *
 * Sources currently point at the Higgsfield CDN where the photos were uploaded.
 * These are public URLs and work fine in a browser, but for launch we should
 * download them into /assets and switch these to local paths so the site owns
 * its own images. See README "Assets" for that step.
 *
 * NOTE: the slot->photo pairings are a first guess made from image dimensions
 * and brightness, not from seeing the photos. Expect to reshuffle them.
 */
const CDN = 'https://d2ol7oe51mr4n9.cloudfront.net/user_3F8bBVZIiZA8w6i5ZF5b1RBHda1/';

export const ASSETS = {
  // Hero — the first thing anyone sees. Wants the most striking blazer shot.
  hero: {
    src: CDN + 'a040d0ab-ff04-40bf-bce2-6c8ba765644b.jpg',
    alt: 'The Grace Blazer in black, embroidered with Product of God’s Grace',
    focus: '50% 42%',
  },

  // Founder portrait beside her story. Wants a photo of Monique herself.
  portrait: {
    src: CDN + '6149b471-fd24-4234-9279-61e7d8809d90.jpg',
    alt: 'Monique M. Lovelace, founder of Mo God Mo Love',
    focus: '50% 30%',
  },

  // Shop cards.
  productGrace: {
    src: CDN + 'f86474fa-48e7-441f-b6f8-1eac2b2eaec9.jpg',
    alt: 'The Grace Blazer, front view',
    focus: '50% 45%',
  },
  productLegacy: {
    src: CDN + '00b40763-718f-485f-9204-f136bf7807e9.jpg',
    alt: 'The Legacy Blazer, coming soon',
    focus: '50% 45%',
  },

  // Embroidery detail strip — the three words, up close. These carry the whole
  // brand story, so close crops of the collar and pocket flaps belong here.
  detailProductOf: {
    src: CDN + '32aca023-6efd-4f92-a0cb-4b8c1c25abb6.jpg',
    alt: '“Product of” embroidered down the collar',
    focus: '50% 35%',
  },
  detailGods: {
    src: CDN + '40a7c552-3301-473f-951b-3de32ad82756.jpg',
    alt: '“God’s” embroidered on the left pocket flap',
    focus: '50% 50%',
  },
  detailGrace: {
    src: CDN + '00463bcb-9052-4608-83db-93fa2b7e60cb.jpg',
    alt: '“Grace” embroidered on the right pocket flap',
    focus: '50% 50%',
  },

  // Wide banner behind the closing verse.
  verseBanner: {
    src: CDN + '09e5daf7-45ca-4628-8b09-271c0abc46a4.jpg',
    alt: '',
    focus: '50% 50%',
  },
};

/* Unused so far — kept so nothing gets lost when we reshuffle slots.
 * b4b1f041-d996-451f-be99-eeef8b3266e9.png  (poster graphic, 1024x1536)
 * 7451ce5a-8bdc-4e3d-a292-ebcc9ceb3c06.jpg  (duplicate of 32aca023)
 */
