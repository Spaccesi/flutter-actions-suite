# Flutter Multi-Platform Build & Deploy Action

This GitHub Action builds and deploys Flutter applications for iOS, Android, Web, macOS, Windows, and Linux. It supports modular builds via boolean flags and deployment to App Store Connect, Firebase App Distribution, and Firebase Hosting.

## Features

- **Multi-Platform**: Support for iOS, Android, Web, and Desktop.
- **Pre-build hooks**: Run `build_runner` or other scripts before building.
- **Signing**: Automated signing setup for iOS and Android.
- **Deployment**:
    - iOS: App Store Connect, Firebase App Distribution.
    - Android: Firebase App Distribution.
    - Web: Firebase Hosting.

## Usage

```yaml
name: Build & Deploy

on:
  push:
    tags:
      - 'v*'

jobs:
  build_deploy:
    runs-on: macos-latest # Required for iOS/macOS. Use ubuntu-latest if only building Android/Web/Linux.
    steps:
      - uses: actions/checkout@v3
      
      - name: Build All
        uses: ./ # Or your-username/your-repo@v1
        with:
          flutter-version: '3.19.0'
          flavor: 'production'
          
          # Platforms to build
          build-ios: 'true'
          build-android: 'true'
          build-web: 'true'
          
          # Pre-build
          pre-build-script: |
            flutter pub run build_runner build --delete-conflicting-outputs

          # Deployment
          deploy-target: 'firebase' # for mobile
          
          # iOS Secrets
          certificate-base64: ${{ secrets.IOS_CERTIFICATE_BASE64 }}
          certificate-password: ${{ secrets.IOS_CERTIFICATE_PASSWORD }}
          provisioning-profile-base64: ${{ secrets.IOS_PROVISIONING_PROFILE_BASE64 }}
          
          # Android Secrets
          keystore-base64: ${{ secrets.ANDROID_KEYSTORE_BASE64 }}
          keystore-password: ${{ secrets.ANDROID_KEYSTORE_PASSWORD }}
          key-alias: ${{ secrets.ANDROID_KEY_ALIAS }}
          key-password: ${{ secrets.ANDROID_KEY_PASSWORD }}

          # Firebase
          firebase-app-id: ${{ secrets.FIREBASE_APP_ID }}
          firebase-service-credentials: ${{ secrets.FIREBASE_SERVICE_CREDENTIALS }}
          firebase-groups: 'qa-team'
```

## Inputs

### General
| Input | Description | Default |
| --- | --- | --- |
| `flutter-version` | Flutter version. | `stable` |
| `working-directory` | Path to project root. | `.` |
| `flavor` | Build flavor. | |
| `dart-defines` | Dart defines (`KEY=VALUE`). | |
| `build-name` | Version Name. | |
| `build-number` | Version Number. | |
| `pre-build-script` | Script to run before build. | |
| `deploy-target` | `appstore`, `firebase`, or `both`. | `appstore` |

### Platforms (Boolean)
| Input | Default |
| --- | --- |
| `build-ios` | `false` |
| `build-android` | `false` |
| `build-web` | `false` |
| `build-macos` | `false` |
| `build-windows` | `false` |
| `build-linux` | `false` |

### iOS Configuration
| Input | Description |
| --- | --- |
| `certificate-base64` | P12 Certificate. |
| `certificate-password` | P12 Password. |
| `provisioning-profile-base64` | Provisioning Profile. |
| `export-options-plist` | Path to ExportOptions.plist. |
| `app-store-connect-*` | App Store Connect API Headers. |

### Android Configuration
| Input | Description |
| --- | --- |
| `keystore-base64` | Upload Keystore (base64). |
| `keystore-password` | Store Password. |
| `key-alias` | Key Alias. |
| `key-password` | Key Password. |

### Firebase Configuration
| Input | Description |
| --- | --- |
| `firebase-app-id` | App ID (Mobile). |
| `firebase-service-credentials` | Service Account JSON. |
| `firebase-groups` | Tester Groups. |
| `firebase-release-notes` | Release Notes. |
| `firebase-hosting-target` | Hosting Target (Web). |

## Notes
- To build for **macOS/iOS**, you must run on a `macos` runner.
- To build for **Windows**, you must run on a `windows` runner.
- To build for **Linux**, use `ubuntu` runner.
- If you select multiple disparate platforms (e.g., Windows + iOS) in one job, it will likely fail unless you use a matrix strategy in your workflow calling this action, or use a self-hosted runner with cross-compilation capabilities (which is limited for Flutter).
