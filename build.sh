#!/bin/bash

arduino-cli --verbose core install 'esp32:esp32@2.0.11'

arduino-cli --verbose lib install WiFiManager@2.0.16-rc.2 Arduino_JSON@0.2.0 U8g2@2.34.22

# In some cases, actions/checkout@v4 will check out a detached HEAD; for
# example, this happens on pull request events, where an hypothetical
# PR merge commit is checked out. This tends to confuse
# `arduino-cli lib install --git-url`, making it fail with errors such as:
#   Error installing Git Library: Library install failed: object not found
# Create and check out a dummy branch to work around this issue.

#git checkout -b check
ARDUINO_LIBRARY_ENABLE_UNSAFE_INSTALL="true" arduino-cli --verbose lib install --git-url .

arduino-cli --verbose compile 'examples/OneOpenAir' --fqbn 'esp32:esp32:esp32c3' --board-options 'JTAGAdapter=default,CDCOnBoot=cdc,PartitionScheme=min_spiffs,CPUFreq=160,FlashMode=qio,FlashFreq=80,FlashSize=4M,UploadSpeed=921600,DebugLevel=verbose,EraseFlash=none'

# TODO: at this point it would be a good idea to run some smoke tests on
# the resulting image (e.g. that it boots successfully and sends metrics)
# but that would either require a high fidelity device emulator, or a
# "hardware lab" runner that is directly connected to a relevant device.

