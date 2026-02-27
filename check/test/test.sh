FLAGS="-r github"

[ "$NO_PUB" == 'true' ] && FLAGS="$FLAGS --no-pub"
[ "$CONCURRENCY" != '' ] && FLAGS="$FLAGS --concurrency=$CONCURRENCY"
[ "$DART_DEFINE" != '' ] && FLAGS="$FLAGS --dart-define=$DART_DEFINE"
[ "$DART_DEFINE_FROM_FILE" != '' ] && FLAGS="$FLAGS --dart-define-from-file=$DART_DEFINE_FROM_FILE"
[ "$FLAVOR" != '' ] && FLAGS="$FLAGS --flavor=$FLAVOR"
[ "$TIMEOUT" != '60s' ] && FLAGS="$FLAGS --timeout=$TIMEOUT"
[ "$IGNORE_TIMEOUTS" == 'true' ] && FLAGS="$FLAGS --ignore-timeouts"
[ "$RUN_COVERAGE" == 'true' ] && FLAGS="$FLAGS --coverage"

echo "▶️ Running flutter test with flags: $FLAGS"
flutter test . $FLAGS
echo "✅ Tests passed."

if [ "$CREATE_COVERAGE_BADGE" == 'true' ]; then
  if ! command -v genhtml &> /dev/null; then
    echo "::group::ℹ️ Installing lcov"
    sudo apt-get install lcov -y
    echo "::endgroup::"
  fi
  echo "☑️ genhtml available"

  echo "▶️ Generating coverage report at $COVERAGE_BADGE_OUTPUT_PATH"
  genhtml coverage/lcov.info -o "$COVERAGE_BADGE_OUTPUT_PATH"
  echo "✅ Coverage report generated."
fi
