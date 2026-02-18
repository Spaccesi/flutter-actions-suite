# Flutter Build

Builds a Flutter application for a specific platform. Includes a top-level orchestrator action and platform-specific sub-actions.

## Structure

```
build/
├── action.yml          # Orchestrator: setup Flutter, install deps, then build
├── ios/action.yaml     # iOS-specific build
├── android/action.yaml # Android-specific build (planned)
├── web/action.yaml     # Web-specific build (planned)
├── macos/action.yaml   # macOS-specific build (planned)
├── windows/action.yaml # Windows-specific build (planned)
└── linux/action.yaml   # Linux-specific build
```

## Usage

### Orchestrator Action

The top-level `build/` action sets up Flutter, installs dependencies, and delegates to the correct platform script:

```yaml
- name: Build
  uses: spaccesi/flutter-actions-suite/build@v1
  with:
    flutter-version: '3.29.0'
    platform: 'ios'
    flavor: 'production'
    build-name: '1.0.0'
    build-number: '${{ github.run_number }}'
```

### Platform-Specific Actions

Use a platform sub-action directly when Flutter is already set up in a previous step:

```yaml
- name: Build iOS
  uses: spaccesi/flutter-actions-suite/build/ios@v1
  with:
    flavor: 'production'
    build-name: '1.0.0'
    build-number: '${{ github.run_number }}'
```

## Inputs (Orchestrator)

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| `flutter-version` | The Flutter version to use. | Yes | `stable` |
| `working-directory` | The working directory of the Flutter project. | No | `.` |
| `platform` | Platform to build (`ios`, `android`, `web`, `macos`, `windows`, `linux`). | Yes | |
| `flavor` | Build flavor. | No | |
| `dart-defines` | Dart defines in `KEY=VALUE` format, one per line. | No | |
| `build-name` | The build name (version string). | No | |
| `build-number` | The build number. | No | |
| `export-options-plist` | Path to iOS `ExportOptions.plist` (iOS only). | No | |

## Inputs (Platform Sub-Actions)

Each platform sub-action (`build/ios`, `build/linux`, etc.) accepts:

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| `flavor` | Build flavor. | No | `''` |
| `build-name` | The build name. | No | `''` |
| `build-number` | The build number. | No | `''` |

## Runner Requirements

| Platform | Runner |
| --- | --- |
| iOS | `macos-latest` |
| Android | `ubuntu-latest` |
| Web | `ubuntu-latest` |
| macOS | `macos-latest` |
| Windows | `windows-latest` |
| Linux | `ubuntu-latest` |

## Workspaces & Monorepos

For monorepos, use the `working-directory` input to point to the correct package:

```yaml
- name: Build App
  uses: spaccesi/flutter-actions-suite/build@v1
  with:
    flutter-version: '3.29.0'
    platform: 'ios'
    working-directory: 'packages/app'
```

For building multiple packages, use a matrix strategy:

```yaml
jobs:
  build:
    runs-on: macos-latest
    strategy:
      matrix:
        package: [packages/app, packages/admin]
    steps:
      - uses: actions/checkout@v4
      - name: Build
        uses: spaccesi/flutter-actions-suite/build@v1
        with:
          flutter-version: '3.29.0'
          platform: 'ios'
          working-directory: ${{ matrix.package }}
```
