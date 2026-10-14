#!/usr/bin/env bash
# Creates the Product of God's Grace listing and a Payment Link in Stripe.
#
# Run it yourself so your secret key never leaves your machine:
#
#   export STRIPE_KEY=sk_test_...        # test key first, see note below
#   bash scripts/create-stripe-product.sh
#
# Start with a TEST key (sk_test_...). Everything it creates lives in test
# mode, costs nothing and can be deleted. When the checkout looks right,
# re-run with the live key (sk_live_...) to make the real one.
set -euo pipefail

# ---- the only things you should need to change -------------------------
SHIPPING_CENTS=900                 # $9.00 flat. SHE STILL HAS TO CONFIRM THIS.
PRICE_CENTS=6800                   # $68.00
IMAGE="https://bobbydigital513.github.io/mo-god-mo-love/assets/img/grace-studio.jpg"
# ------------------------------------------------------------------------

: "${STRIPE_KEY:?Set STRIPE_KEY first, e.g. export STRIPE_KEY=sk_test_...}"
S=(-sS -u "$STRIPE_KEY:" -H "Content-Type: application/x-www-form-urlencoded")
api() { curl "${S[@]}" "https://api.stripe.com/v1/$1" "${@:2}"; }
id_of() { python3 -c 'import sys,json; d=json.load(sys.stdin);
print(d["id"]) if "id" in d else sys.exit("Stripe error: "+d.get("error",{}).get("message","unknown"))'; }

echo "1/4  product..."
PRODUCT=$(api products \
  -d "name=Product of God's Grace" \
  -d "description=Black. Embroidered lapel and pockets. Highly recommend ordering a size up." \
  -d "images[]=$IMAGE" | id_of)
echo "     $PRODUCT"

echo "2/4  price..."
PRICE=$(api prices \
  -d "product=$PRODUCT" -d "unit_amount=$PRICE_CENTS" -d "currency=usd" | id_of)
echo "     $PRICE"

echo "3/4  shipping rate..."
SHIP=$(api shipping_rates \
  -d "display_name=Standard shipping" -d "type=fixed_amount" \
  -d "fixed_amount[amount]=$SHIPPING_CENTS" -d "fixed_amount[currency]=usd" | id_of)
echo "     $SHIP"

echo "4/4  payment link..."
LINK=$(api payment_links \
  -d "line_items[0][price]=$PRICE" -d "line_items[0][quantity]=1" \
  -d "shipping_address_collection[allowed_countries][0]=US" \
  -d "shipping_options[0][shipping_rate]=$SHIP" \
  -d "phone_number_collection[enabled]=true" \
  -d "custom_fields[0][key]=size" \
  -d "custom_fields[0][label][type]=custom" \
  -d "custom_fields[0][label][custom]=Size" \
  -d "custom_fields[0][type]=dropdown" \
  -d "custom_fields[0][dropdown][options][0][label]=S"  -d "custom_fields[0][dropdown][options][0][value]=s" \
  -d "custom_fields[0][dropdown][options][1][label]=M"  -d "custom_fields[0][dropdown][options][1][value]=m" \
  -d "custom_fields[0][dropdown][options][2][label]=L"  -d "custom_fields[0][dropdown][options][2][value]=l" \
  -d "custom_fields[0][dropdown][options][3][label]=XL" -d "custom_fields[0][dropdown][options][3][value]=xl" \
  -d "custom_fields[0][dropdown][options][4][label]=2X" -d "custom_fields[0][dropdown][options][4][value]=2x")

echo
echo "$LINK" | python3 -c 'import sys,json; d=json.load(sys.stdin)
if "error" in d: sys.exit("Stripe error: "+d["error"].get("message","unknown"))
print("PAYMENT LINK:", d["url"]); print("(send me that URL and I will wire it to the Shop button)")'
