FROM jumblesoft/circleci-android

ENV EMULATOR_VERSION=24
        
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - \
    sudo apt-get install -y nodejs

# Install the emulators stuff
RUN android-update-sdk "sys-img-armeabi-v7a-android-${EMULATOR_VERSION},\
    sys-img-armeabi-v7a-google_apis-${EMULATOR_VERSION}"

# Create the default emulators
RUN echo "no" | android create avd \
                --force \
                --device "Android Emulator" \
                --name nexus5_${EMULATOR_VERSION} \
                --target android-${EMULATOR_VERSION} \
                --abi default/armeabi-v7a \
                --skin WVGA800 \
                --sdcard 512M

# Warm up the emulators
RUN android-start-emulator nexus5_${EMULATOR_VERSION} && android-kill-emulators
