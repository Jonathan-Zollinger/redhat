FROM redhat/ubi8:8.4
WORKDIR /root
ADD . .
# RUN yum update -y
RUN yum install -y docker ncurses
RUN installer-scripts/install-glow && installer-scripts/install-gum && installer-scripts/install-neofetch-starship
CMD ["/bin/bash"] 
