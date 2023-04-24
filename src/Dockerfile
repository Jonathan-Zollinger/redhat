FROM redhat/ubi8 

# Add all yum repos and rpm's
RUN echo -e "[charm]\nname=Charm\nbaseurl=https://repo.charm.sh/yum/\nenabled=1\ngpgcheck=1\ngpgkey=https://repo.charm.sh/yum/gpg.key" >> /etc/yum.repos.d/charm.repo
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# Do all yum installs
RUN yum install -y git glow gum unzip wget curl dirmngr man gnupg2 wget nodejs cmake

# ---- install nvim ----
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract; ./squashfs-root/AppRun --version

WORKDIR /root/
COPY . .

RUN mkdir .config
RUN echo -e "\nalias ls='ls --color' \nalias ll='ls -la'\nalias vi='nvim'\nalias vim='nvim'" >> ~/.config/aliases.sh

# TODO add importing statements to .bashrc

RUN dnf copr enable atim/starship -y; dnf install -y starship
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc
