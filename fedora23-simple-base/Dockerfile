# our base image
FROM fedora:23

RUN dnf install -y http://repos.halvm.org/23/x86_64/halvm-yum-repo-23-2.fc23.noarch.rpm && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-HaLVM && \
    dnf install -y HaLVM
