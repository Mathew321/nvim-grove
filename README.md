# Installation
If you're using Ubuntu or any other Debian-based distribution (which uses apt), you can install the required dependencies and build Neovim with the following steps:

## Prerequisites:
Install the necessary build dependencies:

```
sudo apt update
sudo apt install -y ninja-build libtool autoconf cmake g++ pkg-config lua5.1 liblua5.1-0-dev libuv1-dev libtermkey-dev libvterm-dev gettext
```

Steps to Build Neovim:
Clone the Neovim repository:

Clone the official Neovim repository from GitHub.
```
git clone https://github.com/neovim/neovim.git
cd neovim
```

### Compile Neovim:

Build Neovim using make. The CMAKE_BUILD_TYPE=Release flag ensures that you build a release version, which is more optimized than a debug build.
```
make CMAKE_BUILD_TYPE=Release
```

If you'd like to enable additional features (like Lua support), this is the point where you can configure additional CMake options.

### Install Neovim:

After the build process finishes, you can install Neovim to your system:
```
sudo make install
```

### Verify Installation:

Once installed, check the version to ensure everything is working correctly:
```
nvim --version
```

Additional Notes:
You can skip the Lua and other optional dependencies if you don't need them, but enabling them will provide a richer experience.

If you encounter any issues, make sure your system is up-to-date, and dependencies are correctly installed.
