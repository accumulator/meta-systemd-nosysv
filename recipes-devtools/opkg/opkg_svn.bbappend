FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PRINC := "${@int(PRINC) + 3}"

inherit systemd

SRC_URI += "file://run-postinst.service"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE = "run-postinst.service"
SYSTEMD_AUTO_ENABLE = "enable"
