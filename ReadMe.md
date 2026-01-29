# Clang Format Github Action

An action that checks code format using `clang-format` tool. Suitable for projects built on C, C++, C#, Objective-C.

[Clang: a C language family frontend for LLVM
](https://clang.llvm.org/)

## Feature:
- It automatically checks the source file's code format, and if there is any code format violation, it exits with a nonzero status.
- Suggests commands for fixing files with formatting violations.

## Inputs

### `sources`
Sources to check by this action. It can be a single file, regex of a folder or multiple selectors separated by comma (`,`).

Default: `"**/*"`.  That means all files in this repository.

Example: If your repository contains many files other than C files, you can try with specific extension like:

`"src/*.h,src/*.c"`

or, for all nested folders

`"src/**/*.h,src/**/*.c"`

### `excludes`
Sources to exclude from this action. It can be a single file, regex of a folder or multiple selectors separated by comma (`,`).

Default: `""`.

### `style`
The style for `clang-format`. Possible values are: `LLVM, GNU, Google, Chromium, Microsoft, Mozilla, WebKit`. If your repository has a `.clang-format` file in the root directory then you can use `file` option here.

Default: `LLVM`

## Outputs

### `clang-format-version`
The version of clang-format used by this action. This can be useful when you need to verify which version ran or use it in subsequent workflow steps.

Example usage:
```yaml
- uses: RafikFarhad/clang-format-github-action@v6
  id: clang-format
  with:
    sources: "src/**/*.h,src/**/*.c"

- run: echo "Formatted with clang-format version ${{ steps.clang-format.outputs.clang-format-version }}"
```

## Sample Workflow File
Create a file in `.github/workflows/` folder with:

```
name: Clang Format Checker
on: [push]
jobs:
  clang-format-checking:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - uses: RafikFarhad/clang-format-github-action@v6
        with:
          sources: "src/**/*.h,src/**/*.c,test/**/*.c"
```

It will check for code formatting violations on every `push` to GitHub.

## Version

The latest version of this action uses `clang-format` version 21.
Use older versions for specific `clang-format` versions.

| Clang Version | Action |
|---------|---------------|
| 21 | RafikFarhad/clang-format-github-action@v6 |
| 20 | RafikFarhad/clang-format-github-action@v5.1 |
| 19 | RafikFarhad/clang-format-github-action@v5 |
| 18 | RafikFarhad/clang-format-github-action@v4.1 |
| 16 | RafikFarhad/clang-format-github-action@v4 |
| 14 | RafikFarhad/clang-format-github-action@v3 |
| 12 | RafikFarhad/clang-format-github-action@v2.1.0 |
| 10 | RafikFarhad/clang-format-github-action@v1.0.1 |

Kudos to
- [@silkeh](github.com/silkeh) for his awesome [docker image](https://hub.docker.com/r/silkeh/clang).
- [@LinkTed](github.com/LinkTed)
- [@aadeg](github.com/aadeg)
- [y-guyon](https://github.com/y-guyon)

## Contribution

Feel free to submit a PR and/or raise an issue.

🌞 Thanks for using 🌞
