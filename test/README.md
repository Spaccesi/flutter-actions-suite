# Flutter Test

Runs Flutter tests with optional coverage reporting and deployment.

## Usage

### Basic

```yaml
- name: Test
  uses: spaccesi/flutter-actions-suite/test@v1
```

### With Coverage Report

```yaml
- name: Test with Coverage
  uses: spaccesi/flutter-actions-suite/test@v1
  with:
    run-coverage: 'true'
    deploy-report: 'artifact'
```

### Deploy Coverage to GitHub Pages

```yaml
- name: Test with Coverage
  uses: spaccesi/flutter-actions-suite/test@v1
  with:
    run-coverage: 'true'
    deploy-report: 'github-pages'
    github-token: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| `dart-define` | Key-value pairs for `String.fromEnvironment`, etc. | No | `''` |
| `dart-define-from-file` | Path to a `.json` or `.env` file with environment variables. | No | `''` |
| `flavor` | App flavor to use when running tests. | No | `''` |
| `concurrency` | Number of concurrent test processes. | No | `1` |
| `timeout` | Timeout for individual tests (`60s`, `2x`, or `none`). | No | `60s` |
| `ignore-timeouts` | Ignore all timeouts. Useful for large apps or integration tests. | No | `false` |
| `run-coverage` | Run tests with coverage collection. | No | `false` |
| `deploy-report` | Deploy HTML coverage report: `none`, `github-pages`, or `artifact`. | No | `none` |
| `github-token` | GitHub token. Required when `deploy-report` is `github-pages`. | No | `''` |

## What It Does

1. Runs `flutter test` with the configured options and GitHub reporter format.
2. If coverage is enabled, appends `--coverage` to collect `lcov.info`.
3. If report deployment is enabled, installs `lcov` and generates an HTML report with `genhtml`.
4. Deploys the report to GitHub Pages or uploads it as a workflow artifact.

## Workspaces & Monorepos

This action runs tests from the current working directory. For monorepos with right workspace configuration will work perfecly. If workspace configuration is not available to you yet, custom action may be needed.
