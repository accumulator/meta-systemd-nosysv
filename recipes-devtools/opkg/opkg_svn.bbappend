FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PRINC := "${@int(PRINC) + 3}"

inherit systemd

SRC_URI += "file://run-postinst.service"

SYSTEMD_SERVICE_${PN} = "run-postinst.service"

do_install_append() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/run-postinst.service ${D}${systemd_unitdir}/system
}
