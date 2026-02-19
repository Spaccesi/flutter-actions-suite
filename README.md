# Flutter Multi-Platform Github Actions Suite

This GitHub Action prepares, checks, builds and deploys Flutter applications for iOS, Android, Web, macOS, Windows, and Linux. It supports modular builds via boolean flags and deployment to App Store Connect, Firebase App Distribution, Firebase Hosting, Play Store, Microsoft Store, and Snap Store.


## Features

- **Multi-Platform**: Support for iOS, Android, Web, and Desktop (macOS, Windows, Linux).
- **Modular Architecture**: Use the full pipeline or individual actions independently.
- **Pre-build hooks**: Automatic `build_runner` and `gen-l10n` code generation.
- **Signing**: Automated signing setup for iOS and Android.
- **Testing**: Run tests with coverage reports, deployable to GitHub Pages or as artifacts.
- **Documentation**: Generate project documentation with `dartdoc`.
- **Deployment**:
    - iOS: App Store Connect, Firebase App Distribution.
    - Android: Firebase App Distribution.
    - Web: Firebase Hosting.
    - macOS: App Store Connect
    - Linux: Snap
    - Windows: Windows Store

## Parallel multi-platform CI with jobs

The [flutter_ci_jobs.yml](./examples/flutter_ci_jobs.yml) example shows a recommended two-phase workflow that prepares your repository once and then builds every platform concurrently.

**Phase 1 — Prepare & Check** runs on a single `ubuntu-latest` runner and performs all the work that is shared across platforms: `flutter pub get`, optional code generation (`build_runner`, `gen-l10n`), static analysis, and tests. Once everything passes, the fully-prepared workspace is uploaded as a GitHub Actions artifact so the build jobs never need to re-run code generation.

**Phase 2 — Platform builds** start in parallel as soon as Phase 1 succeeds. Each job downloads the prepared workspace, restores pub packages from the Actions cache, and builds its target platform on the appropriate runner (ubuntu for Android/Web/Linux, macos for iOS/macOS, windows for Windows).

```
Phase 1                        Phase 2 (parallel)
──────────────────────         ──────────────────────────────────────────
prepare & check (ubuntu)  →    build-android  (ubuntu-latest)
                          →    build-ios      (macos-latest)
                          →    build-web      (ubuntu-latest)
                          →    build-windows  (windows-latest)
                          →    build-macos    (macos-latest)
                          →    build-linux    (ubuntu-latest)
```

This pattern avoids redundant code-generation on every runner, keeps total wall-clock time close to the slowest single platform build, and gates all platform builds behind a single quality gate.

See [examples/flutter_ci_jobs.yml](./examples/flutter_ci_jobs.yml) for the full workflow.

## Modular Actions

Each step of the pipeline is available as an independent action. This gives you full control over your CI/CD pipeline.

| Action | Path | Description |
| --- | --- | --- |
| **Check** | [`/check`](./check) | Composite action for analysis, licenses, and tests. |
| **Analyze** | [`/check/analyze`](./check/analyze) | Run static analysis and formatting checks. |
| **Test** | [`/check/test`](./check/test) | Run tests with optional coverage reports. |
| **License** | [`/check/license`](./check/license) | Check compatibility of dependency licenses. |
| **Prepare** | [`/prepare`](./prepare) | Composite action for environment setup and code generation. |
| **Build Runner** | [`/prepare/build_runner`](./prepare/build_runner) | Run `build_runner` across the repository. |
| **Gen L10n** | [`/prepare/gen-l10n`](./prepare/gen-l10n) | Run `gen-l10n` localization across the repository. |
| **Docs** | [`/docs`](./docs) | Generate project documentation with `dartdoc`. |
| **Build** | `/build/{platform}` | Build project (ios/android/web/macos/windows/linux). |
| **Publish** | `/publish/{platform}` | TODO |

## Usage

### Using Individual Actions

You can use sub-actions to have more granular control:

```yaml
- name: Code Generation
  uses: Spaccesi/flutter-actions-suite/prepare/build_runner@main

- name: Run Tests
  uses: Spaccesi/flutter-actions-suite/check/test@main
  with:
    run-coverage: 'true'
```

## Notes

- **macOS/iOS**: Requires `macos` runner.
- **Windows**: Requires `windows` runner.
- **Linux**: Requires `ubuntu` runner.
