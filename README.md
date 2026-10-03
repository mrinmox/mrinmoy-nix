
# Mrinmoy Nix Development Environments

Reproducible development environments built with **Nix flakes** and **direnv** on Ubuntu.

The repository provides separate environments for:

- General development tooling
- C development
- Zephyr RTOS development

## Requirements

- Ubuntu Linux
- Nix with flakes enabled
- direnv

## Development Environments

### 1. General Tooling

Enter the tooling environment:

```bash
nix develop .#tooling
```

Provides:

- Helix
- tmux
- Julia

---

### 2. C Development

Enter the C development environment:

```bash
nix develop .#c
```

Provides:

- GCC
- GDB
- CMake
- Ninja
- GNU Make
- clangd
- clang-format
- cppcheck
- pkg-config

---

### 3. Zephyr Development

Enter the Zephyr environment:

```bash
nix develop .#zephyr
```

Provides:

- Python
- West
- CMake
- Ninja
- QEMU
- GCC
- GDB

The environment uses the existing Zephyr source tree and Zephyr SDK installed on the host.

Expected locations:

```text
~/projects/zephyr-workspace/zephyr
~/zephyr-sdk-1.0.1
```

## direnv

`direnv` can automatically load the appropriate Nix environment when entering a project directory.

Example:

```bash
use flake /path/to/mrinmoy-nix#tooling
```

For C:

```bash
use flake /path/to/mrinmoy-nix#c
```

For Zephyr:

```bash
use flake /path/to/mrinmoy-nix#zephyr
```

After creating an `.envrc`:

```bash
direnv allow
```

## Reproducibility

The repository contains:

```text
flake.nix
flake.lock
```

`flake.nix` defines the development environments.

`flake.lock` pins the exact versions of the Nix inputs used by the environments.

To reproduce the environments on another machine:

```bash
git clone https://github.com/mrinmox/mrinmoy-nix.git
cd mrinmoy-nix
```

Then choose an environment:

```bash
nix develop .#tooling
```

```bash
nix develop .#c
```

```bash
nix develop .#zephyr
```

## Updating Dependencies

Update the locked Nix dependencies with:

```bash
nix flake update
```

Review the changes and commit the updated lock file:

```bash
git add flake.lock
git commit -m "Update Nix dependencies"
git push
```

## Philosophy

Ubuntu is used as the host operating system for:

- Hardware
- Drivers
- System services
- Desktop environment

Nix is used to provide reproducible development environments without replacing the Ubuntu host system.

## Repository

GitHub:

https://github.com/mrinmox/mrinmoy-nix
