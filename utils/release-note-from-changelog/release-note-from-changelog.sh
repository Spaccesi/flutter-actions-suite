echo "::group::ℹ️ Extracting release note from $CHANGELOG_PATH"
if [ ! -f "$CHANGELOG_PATH" ]; then
    echo "::error::🚨 Changelog file not found at path: $CHANGELOG_PATH"
    if [[ "$FAILS_ON_MISSING_CHANGELOG" == "true" ]]; then
        exit 1
    fi
fi

# Extract the latest release note from the changelog
RELEASE_NOTE=$(awk '/^# /{if(flag) exit; flag=1; next} flag' "$CHANGELOG_PATH")
if [ -z "$RELEASE_NOTE" ]; then
        echo "::error::🚨 No release note found in the changelog."
    if [[ "$FAILS_ON_MISSING_CHANGELOG" == "true" ]]; then
        exit 1
    fi
fi

echo "Release note extracted from changelog:"
echo "$RELEASE_NOTE"

# Set the release note as an output variable
{
    echo "release_note<<EOF"
    echo "$RELEASE_NOTE"
    echo "EOF"
} >> "$GITHUB_OUTPUT"
echo "::endgroup::"
echo "✅ Release note extracted!"