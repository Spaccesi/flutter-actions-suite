if ! dart pub global list | grep -q "^license_checker "; then
  echo "::group::ℹ️ Installing license_checker"
  dart pub global activate license_checker
  echo "::endgroup::"
fi
echo "☑️ license_checker available"

echo "▶️ Running license check"
OUTPUT=$(lic_ck check-licenses -c $COMPATIBLE_LECENSES_CONF_PATH -i -a)

if ! echo "$OUTPUT" | grep -q "No package licenses need approval!"; then
  echo "::error::🚨 Found incompatible licenses."
  echo "$OUTPUT"
  exit 1
fi

echo "✅ All licenses are compatible."
