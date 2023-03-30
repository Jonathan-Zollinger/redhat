FROM redhat/ubi8 

# Add all yum repos and rpm's
RUN echo -e "[charm]\nname=Charm\nbaseurl=https://repo.charm.sh/yum/\nenabled=1\ngpgcheck=1\ngpgkey=https://repo.charm.sh/yum/gpg.key" >> /etc/yum.repos.d/charm.repo
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

# Do all yum installs
RUN yum install -y git golang glow gum ca-certificates unzip wget curl dirmngr man gnupg2 wget gcc gcc-c++ neovim python3-neovim nodejs cmake

RUN git clone https://go.googlesource.com/go goroot; cd goroot/src; ./all.bash

ENV PATH /usr/local/go/bin:$PATH
ENV GOPATH /usr/local/go
ENV GOLANG_VERSION 1.20.2
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin"; chmod -R 777 "$GOPATH"

RUN go install golang.org/x/tools/gopls@latest

RUN echo -e "\n# whale theme\nBack=\"#1a1e2a\"\nFront=\"#ffffff\"\nDark1=\"#242D42\"\nDark2=\"#212739\"\nBlue=\"#5eadfc\"\nGrey=\"#6a6f87\"\nPink=\"#fa5ead\"\nGreen=\"#00fbad\"\n\n# gum-filter colors\nexport GUM_FILTER_INDICATOR_FOREGROUND=\$Green\nexport GUM_FILTER_SELECTED_PREFIX_FOREGROUND=\$Dark1\nexport GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND=\$Grey\nexport GUM_FILTER_TEXT_FOREGROUND=\$Front\nexport GUM_FILTER_MATCH_FOREGROUND=\$Blue\nexport GUM_FILTER_PROMPT_FOREGROUND=\$Blue\n\n" >> ~/.config/CharmColorScheme.sh

# ---- install nvim ----
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
RUN chmod u+x nvim.appimage
RUN ./nvim.appimage --appimage-extract; ./quashfs-root/AppRun --version

# install LSP's
RUN echo -e "\nalias ls='ls --color' \nalias ll='ls -la'\nalias vi='nvim'\nalias vim='nvim'" >> ~/.config/aliases.sh

# TODO add importing statements to .bashrc

RUN dnf copr enable atim/starship -y; dnf install -y starship
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc
