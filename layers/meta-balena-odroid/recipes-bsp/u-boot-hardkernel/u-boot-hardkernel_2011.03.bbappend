UBOOT_KCONFIG_SUPPORT = "0"
inherit resin-u-boot

SRC_URI_remove_odroid-c1 = "file://resin-specific-env-integration-non-kconfig.patch"

FILESEXTRAPATHS_prepend_odroid-c1 := "${THISDIR}/${PN}:"

SRC_URI_append_odroid-c1 = " \
    file://0001-COMMON-Add-__stringify-function.patch \
    file://0001-cmd_part-add-partition-related-command.patch \
    file://0001-disk-part-check-bootable-flag-for-DOS-partitions.patch \
    file://0001-disk-part-introduce-get_device_and_partition.patch \
    file://0001-disk-introduce-get_device.patch \
    file://0001-disk-get_device_and_partition-auto-partition-and-cle.patch \
    file://0001-disk-part_efi-parse-and-store-partition-UUID.patch \
    file://0001-disk-part_msdos-parse-and-store-partition-UUID.patch \
    file://0001-Add-cmd_process-to-process-commands-in-one-place.patch \
    file://resin-specific-env-integration-non-kconfig_REWORKED.patch \
    file://0001-odroidc.h-Add-the-machine-specific-integration-of.patch \
    file://0001-odroid-c1-Enable-CONFIG_CMD_SETEXPR.patch \
    "

do_deploy_append_odroid-c1 () {
    install ${WORKDIR}/boot.ini ${DEPLOYDIR}/boot.ini
}

# Fix max recursive bug:
# ERROR: ExpansionError during parsing u-boot-hardkernel_2011.03.bb: Failure expanding
# variable SRCPV, expression was ${@bb.fetch2.get_srcrev(d)} which triggered exception
# RuntimeError: maximum recursion depth exceeded in __instancecheck__
PV = "v2011.03+${SRCREV}"

S = "${WORKDIR}/git"
