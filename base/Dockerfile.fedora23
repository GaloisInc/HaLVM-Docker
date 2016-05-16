# our base image
FROM fedora:23

RUN dnf install -y http://repos.halvm.org/23/x86_64/halvm-yum-repo-23-2.fc23.noarch.rpm && dnf update -y
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-HaLVM
RUN dnf install -y HaLVM vim tmux zsh git

VOLUME  /halvm
WORKDIR /halvm
