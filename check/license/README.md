# Flutter License Check

Check that all dependency licenses are compatible with your project. This action uses [license_checker](https://pub.dev/packages/license_checker) to verify licenses.

## Usage

```yaml
- name: Check Licenses
  uses: Spaccesi/flutter-actions-suite/check/license@main
  with:
    compatible-licenses-conf-path: 'config/compatible_licenses.yaml'
    fail-on-warnings: true
```

## Inputs

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| `compatible-licenses-conf-path` | Path to a file containing a list of compatible licenses. | **Yes** | - |
| `fail-on-warnings` | Fail the action if warnings are found. | No | `false` |
| `fail-on-info` | Fail the action if info messages are found. | No | `false` |

## Compatible Licenses Configuration

The configuration file (e.g., `licenses.yaml`) should list the licenses you accept. Example:

```yaml
permittedLicenses:
  - mit
  - bsd_3_clause
  - apache_2_0
```

## What It Does

1. Activates the `license_checker` Dart package globally.
2. Runs `lic_ck check-licenses` using the provided configuration path.
3. Parses the output for "warning" or "info" strings if configured to fail on them.
4. Fails if the tool returns a non-zero exit code or if prohibited messages are found.
