# `cargo generate-rpm` Build Environment (fedora amd64)

Provides a build environment for executing `cargo generate-rpm` [1] and producing `.rpm` packages.

This builds on a `fedora:44` base image.

The interface for this package was inspired/copied from the cargo-static-build [2] action.

[1] `cargo generate-rpm` provided by cat-in-136
- https://github.com/cat-in-136/cargo-generate-rpm
- https://crates.io/crates/cargo-generate-rpm

[2] https://github.com/zhxiaogg/cargo-static-build

**NOTE**: This package may fail to build your project if your build links against other OS-provided libraries. Feel free to open a pull-request to modify the `Dockerfile` so your project can build.

## Inputs

`cmd` - The command to be executed inside the container. Defaults to computing the Fedora version from RPM macros, then running `cargo build --release && cargo generate-rpm --variant fedora --set-metadata 'release = "1.fc${fedora_version}"'`.

## Outputs

None, besides the `rpm` package that is built. The built `.rpm` will be located in `target/generate-rpm/<RPM>`.

## Example Usage

```yaml
name: RPM Static Build

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: RPM Build
      uses: ebbflow-io/cargo-rpm-amd64-fedora@1.1
```

A working example can be found in use by Ebbflow to build its client package for various OS and CPU architectures [here](https://github.com/ebbflow-io/ebbflow/blob/master/.github/workflows/continuous-integration.yml).
