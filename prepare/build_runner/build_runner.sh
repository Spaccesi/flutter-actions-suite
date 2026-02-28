# Find all packages in the repository
PACKAGES=$(find . -mindepth 1 -maxdepth 3 -type f -name "pubspec.yaml" | sed 's|/pubspec.yaml||')

if [ -z "$PACKAGES" ]; then
    echo "ℹ️ No packages found with pubspec.yaml"
    exit 1
else
    echo "::group::ℹ️ ${#PACKAGES[@]} packages found with pubspec.yaml"
fi

# Run build_runner on each package
for PACKAGE_DIR in $PACKAGES; do
    echo "::group::ℹ️ Running build_runner in $PACKAGE_DIR"

    # Check if the package has build_runner dependency
    if grep -q "build_runner:" "$PACKAGE_DIR/pubspec.yaml"; then
        cd "$PACKAGE_DIR"
        dart run build_runner build --delete-conflicting-outputs
        cd - > /dev/null
        echo "☑️ Completed build_runner for $PACKAGE_DIR"
    else
        echo "⏭️ Skipping $PACKAGE_DIR (no build_runner dependency)"
    fi

    echo "::endgroup::"
done

echo "::endgroup::"
echo "✅ Build runner completed for all packages!"