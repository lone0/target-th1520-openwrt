# OpenWrt Target for T-Head TH1520 SoC

This repo adds a target to OpenWrt for TH1520 SoC

## Getting Started

### 1. Clone the OpenWrt Repository
   
   ```bash
   git clone https://github.com/openwrt/openwrt.git
   cd openwrt
   git checkout openwrt-24.10
   ```

### 2. Add Custom Feed

   ```bash
   echo src-git thead https://github.com/lone0/target-th1520-openwrt.git >> feeds.conf
   ./scripts/feeds update thead
   ./scripts/feeds install thead
   ```
**Verify Installation:**

 ```bash
 $ ls target/linux/feeds/thead/
 base-files  config-6.6  image  Makefile  patches-6.6  th1520
 ```

### 3. Build the code

   ```base
   cp target/linux/feeds/thead/licheepi4a_defconfig .config
   make defconfig
   make menuconfig
   ```

**Customization:**

Modify configurations using `menuconfig` and then:

   ```
   make -j$(nproc)
   ```

   This process takes time. Upon completion, the following files will be generated:
   
- `build_dir/target-riscv64_riscv64_musl/linux-thead_th1520/tmp/openwrt-thead-th1520-sipeed_lpi4a-ext4-sysupgrade.img.gz.kernel` : boot image
- `build_dir/target-riscv64_riscv64_musl/linux-thead_th1520/root.ext4` : root image

### 4. Flash the images to Lichee Pi 4A

   Assuming it is booting from eMMC:

   ```
   sudo fastboot flash ram ../<somewhere>/u-boot-with-spl.bin		# u-boot SPL not included in the openwrt build. Find it in the buildroot-th1520
   sudo fastboot reboot
   sudo fastboot flash boot build_dir/target-riscv64_riscv64_musl/linux-thead_th1520/tmp/openwrt-thead-th1520-sipeed_lpi4a-ext4-sysupgrade.img.gz.kernel
   sudo fastboot flash root build_dir/target-riscv64_riscv64_musl/linux-thead_th1520/root.ext4
   ```

### 5. Enable WiFi on the Device

After flashing the kernel and root filesystem, WiFi is disabled by default. To enable it, access the console of x2000 device:

   ```bash
   uci set wireless.radio0.disabled=0
   uci commit wireless
   service network restart
   ```
Check for the 'OpenWrt' WiFi signal on your mobile device.

### Thanks to

This project is derived from https://github.com/chainsx/openwrt-th1520
