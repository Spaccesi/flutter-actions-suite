# Flutter Multi-Platform Build & Deploy Action

This GitHub Action builds and deploys Flutter applications for iOS, Android, Web, macOS, Windows, and Linux. It supports modular builds via boolean flags and deployment to App Store Connect, Firebase App Distribution, and Firebase Hosting.

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
| **Release** | `/release/{platform}` | Build and Publish project (Desktop/Mobile/Web). |

## Usage

### Full Pipeline Example

```yaml
jobs:
  build:
    runs-on: macos-latest # Required for iOS/macOS
    steps:
      - uses: actions/checkout@v4
      
      - name: Flutter Actions Suite
        uses: Spaccesi/flutter-actions-suite@main
        with:
          flutter-version: '3.19.0'
          github-token: ${{ secrets.GITHUB_TOKEN }}
          deploy-coverage-report: 'github-pages'
```

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

## Action Reference - Root Action (`./`)

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| `flutter-version` | The Flutter version to use. | **Yes** | - |
| `flutter-channel` | Flutter channel (`stable`, `beta`, `dev`, `master`). | No | `stable` |
| `github-token` | Token for GitHub Pages deployment. | No | `''` |
| `deploy-coverage-report` | Options: `none`, `github-pages`, `artifact`. | No | `none` |

## Notes

- **macOS/iOS**: Requires `macos` runner.
- **Windows**: Requires `windows` runner.
- **Linux**: Requires `ubuntu` runner.
