# Aeon GUI

Copyright (c) 2014-2021, The Monero Project, AEON

## Introduction

Aeon is an open-source, peer to peer network that secures a cryptocurrency. You can send and receive money from anyone in the world.

This is the GUI for the [core Aeon implementation](https://github.com/aeonix/aeon). It is open source and completely free to use without restrictions, except for those specified in the license agreement below. There are no restrictions on anyone creating an alternative implementation of Aeon that uses the protocol and network in a compatible manner.

As with many development projects, the repository on Github is considered to be the "staging" area for the latest changes. Before changes are merged into that branch on the main repository, they are tested by individual developers in their own branches, submitted as a pull request, and then subsequently tested by contributors who focus on testing and code reviews. That having been said, the repository should be carefully considered before using it in a production environment, unless there is a patch in the repository for a particular show-stopping issue you are experiencing. It is generally a better idea to use a tagged release for stability.

## Supporting the project

Aeon is a 100% community-run endeavor. If you want to join our efforts, the easiest thing you can do is support the project financially. 

The Aeon donation address is: `WmsSWgtT1JPg5e3cK41hKXSHVpKW7e47bjgiKmWZkYrhSS5LhRemNyqayaSBtAQ6517eo5PtH9wxHVmM78JDZSUu2W8PqRiNs` (viewkey: `71bf19a7348ede17fa487167710dac401ef1556851bfd36b76040facf051630b`)

The Bitcoin donation address is: `12Cyjf3qV6qLyXdzpLSLPdRFPUVidvnzFM`

GUI development funding and/or some supporting services are also graciously provided by [sponsors](https://www.getmonero.org/community/sponsorships/):

[<img width="150" src="https://www.getmonero.org/img/sponsors/tarilabs.png"/>](https://tarilabs.com/)
[<img width="150" src="https://www.getmonero.org/img/sponsors/globee.png"/>](https://globee.com/)
[<img width="150" src="https://www.getmonero.org/img/sponsors/symas.png"/>](https://symas.com/)
[<img width="150" src="https://www.getmonero.org/img/sponsors/forked_logo.png"/>](http://www.forked.net/)
[<img width="150" src="https://www.getmonero.org/img/sponsors/macstadium.png"/>](https://www.macstadium.com/)

There are also several mining pools that kindly donate a portion of their fees, [a list of them can be found on our Bitcointalk post](https://bitcointalk.org/index.php?topic=583449.0).

## Vulnerability response

- Our [Vulnerability Response Process](https://github.com/monero-project/meta/blob/master/VULNERABILITY_RESPONSE_PROCESS.md) encourages responsible disclosure
- We are also available via [HackerOne](https://hackerone.com/monero)

## License

See [LICENSE](LICENSE).

## Compiling the Aeon GUI from source

*Note*: Qt 5.9.7 is the minimum version required to build the GUI.

### On Linux:

(Tested on Ubuntu 17.10 x64, Ubuntu 18.04 x64 and Gentoo x64)

1. Install Aeon dependencies. You can find more details about those dependencies in the [Aeon documentation](https://github.com/aeonix/aeon).

2. Install Qt:

  *Note*: The Qt 5.9.7 or newer requirement makes **some** distributions (mostly based on debian, like Ubuntu 16.x or Linux Mint 18.x) obsolete due to their repositories containing an older Qt version.

 The recommended way is to install 5.9.7 from the [official Qt installer](https://www.qt.io/download-qt-installer) or [compiling it yourself](https://wiki.qt.io/Install_Qt_5_on_Ubuntu). This ensures you have the correct version. Higher versions *can* work but as it differs from our production build target, slight differences may occur.

The following instructions will fetch Qt from your distribution's repositories instead. Take note of what version it installs. Your mileage may vary.

  - For Ubuntu 17.10+

    `sudo apt install qtbase5-dev qt5-default qtdeclarative5-dev qml-module-qtqml-models2 qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-xmllistmodel qml-module-qt-labs-settings qml-module-qt-labs-platform qml-module-qt-labs-folderlistmodel qttools5-dev-tools qml-module-qtquick-templates2 libqt5svg5-dev`

  - For Gentoo

    `sudo emerge dev-qt/qtcore:5 dev-qt/qtdeclarative:5 dev-qt/qtquickcontrols:5 dev-qt/qtquickcontrols2:5 dev-qt/qtgraphicaleffects:5`

  - Optional : To build the flag `WITH_SCANNER`

    - For Ubuntu

      `sudo apt install qtmultimedia5-dev qml-module-qtmultimedia`

    - For Gentoo

      The *qml* USE flag must be enabled.

      `emerge dev-qt/qtmultimedia:5`


3. Clone repository

    ```
    git clone --recursive https://github.com/aeonix/aeon-gui.git
    cd aeon-gui
    ```

4. Build

    ```
    make release -j4
    ```
    \* `4` - number of CPU threads to use  
    \* Add `CMAKE_PREFIX_PATH` enviroment variable to set a custom Qt install directory, e.g. `CMAKE_PREFIX_PATH=$HOME/Qt/5.9.7/gcc_64 make release -j4`

The executable can be found in the build/release/bin folder.

### On OS X:

1. Install Xcode from AppStore

2. Install [homebrew](http://brew.sh/)

3. Install Aeon dependencies. You can find more details about those dependencies in the [Aeon documentation](https://github.com/aeonix/aeon).

4. Install Qt:

  `brew install qt5`  (or download QT 5.9.7+ from [qt.io](https://www.qt.io/download-open-source/))

5. Grab an up-to-date copy of the aeon-gui repository

   ```
   git clone --recursive https://github.com/aeonix/aeon-gui.git
   cd aeon-gui
   ```

6. Start the build

    ```
    make release -j4
    ```
    \* `4` - number of CPU threads to use  
    \* Add `CMAKE_PREFIX_PATH` enviroment variable to set a custom Qt install directory, e.g. `CMAKE_PREFIX_PATH=$HOME/Qt/5.9.7/clang_64 make release -j4`

The executable can be found in the `build/release/bin` folder.

For building an application bundle see `DEPLOY.md`.

### On Windows:

The Aeon GUI on Windows is 64 bits only; 32-bit Windows GUI builds are not officially supported anymore.

1. Install [MSYS2](https://www.msys2.org/), follow the instructions on that page on how to update system and packages to the latest versions

2. Open an 64-bit MSYS2 shell: Use the *MSYS2 MinGW 64-bit* shortcut, or use the `msys2_shell.cmd` batch file with a `-mingw64` parameter

3. Install MSYS2 packages for Aeon dependencies; the needed 64-bit packages have `x86_64` in their names. You can find more details about those dependencies in the [Aeon documentation](https://github.com/aeonix/aeon). Note that that there is no more need to compile Boost from source; like everything else, you can install it now with a MSYS2 package.

4. Install Qt5

    ```
    pacman -S mingw-w64-x86_64-qt5
    ```

    There is no more need to download some special installer from the Qt website, the standard MSYS2 package for Qt will do in almost all circumstances.

5. Install git

    ```
    pacman -S git
    ```

6. Clone repository

    ```
    git clone --recursive https://github.com/aeonix/aeon-gui.git
    cd aeon-gui
    ```

7. Build

    ```
    make release-win64 -j4
    cd build/release
    make deploy
    ```
    \* `4` - number of CPU threads to use

The executable can be found in the `.\bin` directory.
