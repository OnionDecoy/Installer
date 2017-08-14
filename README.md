# Onion Decoy Server

A platform to run private unannounced Honeypots as Tor Hidden Services (aka Onion Decoys) inside the Tor Network.


### Approach Description

The Onion Decoys are implemented with Docker containers as honeypots. The reason to choose Docker is that it is good at process and filesystem isolation, which ultimately gives the ability to run more services on the same box instead of having to deal with resource intensive virtual machines. Also, Docker containers can easily be made very clean, containing no identifying data and having uptimes that are different from the host they're running in, which makes it difficult to get identified from outside. 

The Docker containers are composed with two popular open source honeypots viz. Glastopf for HTTP and Cowrie for SSH & Telnet. The honeypot containers expose three ports viz. port 80 (HTTP), port 22 (SSH) and port 23 (Telnet). Each honeypot container is linked with a separate HS container which together creates the Onion Decoy having a unique onion address. The onion addresses are randomly generated and are not announced publicly anywhere.


```sh
# run a container with a network application
$ docker run -d -p 80:80 --name hello_world_container kitematic/hello-world-nginx

# and just link it to this container
$ docker run -tid --link hello_world_container --name hello_world_torrified_container iotdocktor/container-torrify
```

The .onion URLs will be displayed to stdout at startup.

To keep onion keys, or you already have Hostname/PrivateKey for Tor Hidden Service
just mount volume `/var/lib/tor/hidden_service/`

```sh
$ docker run -d --link hello_world_container --name hello_world_torrified_container --volume /path/to/keys:/var/lib/tor/hidden_service/ iotdocktor/container-torrify
```

### Setup port

By default, ports are the same as linked containers, but a default port can be mapped using `PORT_MAP` environment variable.

__Caution__: Using `PORT_MAP` with multiple ports on single service will cause `tor` to fail.


### Onion Decoy Installation Steps


1> Install __Ubuntu Server 16.04__

2> Install the following Dependencies
```sh
sudo apt-get install apache2-utils apparmor apt-transport-https aufs-tools bash-completion build-essential ca-certificates cgroupfs-mount curl dialog dnsutils docker.io dstat ethtool genisoimage git glances html2text htop iptables iw libltdl7 lm-sensors man nginx-extras nodejs npm ntp openssh-server openssl syslinux psmisc pv python-pip vim wireless-tools wpasupplicant
```

3> Run the following command
```sh
sudo apt-get update
```

4> Copy the ___OnionDecoy/Installer___ Repository contents to ___/root/OD_Installer___

5> Give necessary executable permissions to ___/root/OD_Installer___
```sh
sudo -i nautilus
```

6> Execuite the __Installation Script__
```sh
sudo /root/OD_Installer/install.sh
```

7> After System Reboot, execute the __Decoy Setup Script__ from the home directory
```sh
cd /home/$(SUDO_USER)  or $USER or whoami
sudo ./setup.sh
```

---

### Onion Decoy Server (Pre-Installed Virtual Appliance)
Please Download the OVA Template from here.
[Onion_Decoy_Server_Ubuntu_16_04](https://drive.google.com/open?id=0B8mjYbIXCEyzOXduTFQ0WnBoWE0 "Onion Decoy Server v1.0")