inherit systemd

LICENSE="GPLv2"

SRC_URI="\
    file://sysclock.sh \
    file://sysclock.service \
"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE_${PN} = "sysclock.service"

do_qa_configure() {
}

do_install_append() {
    install -d ${D}/${base_sbindir}
    install -m 755 ${WORKDIR}/sysclock.sh ${D}/${base_sbindir}
}
