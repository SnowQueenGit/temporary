# sync rom.
repo init --depth=1 --no-repo-verify -u git://github.com/Spark-Rom/manifest.git -b fire -g default,-mips,-darwin,-notdefault
git clone https://github.com/rasenss/manifest_local.git --depth 1 -b Aosp .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
lunch spark_ginkgo-user
export WITH_GAPPS=true
export TZ=Asia/Jakarta #put before last build comman
mka spark

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line).
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P