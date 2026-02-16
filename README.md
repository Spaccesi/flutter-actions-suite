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
    - windows: Windwos Store

## Modular Actions

Each step of the pipeline is available as an independent action that you can use separately in your workflows. This gives you full control over your CI/CD pipeline.

| Action | Path | Description |
| --- | --- | --- |
| **Analyze** | `/analyze` | Run static analysis and formatting checks. |
| **Test** | `/test` | Run tests with optional coverage reports. |
| **License** | `/license` | Check license of internal packages. |
| **Build Runner** | `/build_runner` | Run `build_runner` code generation. |
| **Gen L10n** | `/gen-l10n` | Run `gen-l10n` localization code generation. |
| **Build** | `/build/{platform}` | Build for a specific platform. |
| **Publish** | `/publish/{platform}` | Publish project. |
| **Publish Firebase** | `/publish_firebase/{platform}` | Publish project on App Distribution. |
| **Release** | `/release/{platform}` | Build and Publish project. |
| **Docs** | `/docs` | Generate project documentation with `dartdoc`. |

## Usage

### Full Pipeline

TODO

### Using Individual Actions

TODO

### Build for a Specific Platform

TODO

## Action Reference

### Root Action (`./`)

TODO


### Analyze (`analyze`)

TODO

### Test (`test`)

TODO

### Build Runner (`build_runner`)

TODO

### Gen L10n (`gen-l10n`)

TODO

### Build (`build/{platform}`)

TODO

### Publish (`build/{platform}`)

TODO

### Docs (`docs`)

TODO

## Notes

- To build for **macOS/iOS**, you must run on a `macos` runner.
- To build for **Windows**, you must run on a `windows` runner.
- To build for **Linux**, use an `ubuntu` runner.
