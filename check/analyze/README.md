# Flutter Analyze

Runs `flutter analyze` with configurable severity levels.

## Usage

```yaml
- name: Analyze
  uses: spaccesi/flutter-actions-suite/analyze@v1
  with:
    treat-infos-as-fatal: true
    treat-warnings-as-fatal: true
```

## Inputs

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| `treat-infos-as-fatal` | Treat info level issues as fatal. | No | `true` |
| `treat-warnings-as-fatal` | Treat warning level issues as fatal. | No | `true` |

## What It Does

Runs `flutter analyze` on the current project with `--no-pub` (assumes dependencies are already installed). Severity flags control whether info-level or warning-level diagnostics cause the step to fail.

## Workspaces & Monorepos

This action runs `flutter analyze .` from the current working directory. If workspace is correctly configured no need to run this several times. If not, matrix strategy is recommended.
