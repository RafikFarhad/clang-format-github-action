# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Docker-based GitHub Action that checks C/C++/Objective-C code formatting using `clang-format`. It runs clang-format in dry-run mode and fails if any files don't match the expected style.

## Architecture

- **action.yml**: GitHub Action definition with inputs (style, sources, excludes)
- **Dockerfile**: Uses `silkeh/clang:19` base image, copies and runs entrypoint.sh
- **entrypoint.sh**: Main bash script that finds matching files and runs clang-format on each

## Testing Locally

Run the entrypoint script with environment variables:
```bash
INPUT_SOURCES='examples/*.c' INPUT_EXCLUDES='examples/file2.c' INPUT_STYLE="LLVM" GITHUB_WORKSPACE=. ./entrypoint.sh
```

## CI Testing

Tests run on push/PR to master via `.github/workflows/entrypoint-test.yml`. The test verifies file inclusion/exclusion logic works correctly.

## Key Environment Variables

The action receives inputs as environment variables:
- `INPUT_STYLE`: Formatting style (LLVM, GNU, Google, Chromium, Microsoft, Mozilla, WebKit, or "file" to use .clang-format)
- `INPUT_SOURCES`: Comma-separated glob patterns for files to check
- `INPUT_EXCLUDES`: Comma-separated glob patterns for files to exclude
- `GITHUB_WORKSPACE`: Working directory (set by GitHub Actions runtime)
