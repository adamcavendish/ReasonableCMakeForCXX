# Reasonable CMake For C++ Demos
---

[reason.cmake](https://github.com/adamcavendish/reason.cmake) is a CMake wrapper to enhance the build experience for C++.


# Project 1

It shows how to integrate `reason.cmake` with legacy CMake modules, using `add_subdirectory`.

The `module1` and `module2` in the `deps` directory are written completely in native CMake code without any 'reason' integration.

Using legacy modules is risky and buggy because previous CMakeLists.txt might damage the whole build via setting global include directories
and global compile options. Any failed module should be manually converted into reason build, and you will get the benefits from now on.

# Project 2

It shows how to depend on an external reason build project. (Project 2 depends on Project 1)

By showing cmake where the Project 1 is installed via `CMAKE_PREFIX_PATH` variable, you can use `find_package` seamlessly.

Note:
1. If you have already installed `Project1` by package manager, aka. dpkg installed globally into `/usr/` directory,
the global path is already in `CMAKE_PREFIX_PATH`, and there's no extra work at all.
2. The package built (i.e. deb package) does not include files in `Project 1` or any other packages found via `find_package`,
and therefore both packages are required at binary distribution.

# Project 3

It shows how to rewrite `Project 1` with reason.cmake.

# Project 4

It shows how to integrate with header-only libraries, or named 'interface libraries' in CMake.

# Project 5

It shows how multiple executables depend on common libraries are managed in reason.cmake.
