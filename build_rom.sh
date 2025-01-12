# syncing rom
repo init -u https://github.com/Havoc-OS/android_manifest.git -b eleven
git clone https://github.com/SnowQueenGit/local-manifests.git --depth 1 -b master .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# build rom
. build/envsetup.sh
lunch havoc_RMX2170-userdebug
export TZ=Asia/Dhaka #put before last build command
brunch

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
