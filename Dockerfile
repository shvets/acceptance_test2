#
# Acceptance Dockerfile
#

FROM ubuntu:14.04

MAINTAINER Alexander Shvets "alexander.shvets@gmail.com"

# 1. Update system
RUN sudo apt-get update
RUN sudo locale-gen en_US.UTF-8

# 2. Install sshd

RUN sudo apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed --in-place=.bak 's/without-password/yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD /usr/sbin/sshd -D

# 3. Create vagrant user
RUN groupadd vagrant
RUN useradd -d /home/vagrant -g vagrant -m -s /bin/bash vagrant
RUN sudo sed -i '$a vagrant    ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN echo vagrant:vagrant | chpasswd
RUN sudo chown -R vagrant /home/vagrant

# 4. Prepare directories for the project

# Add project dir to docker

ADD . /home/vagrant/demo
WORKDIR /home/vagrant/demo

EXPOSE 9292

# Define default command.
CMD ["bash"]

