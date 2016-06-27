---
layout: post
title: Building a media server using an old pc
date: 2016-06-20 22:42:00 +0200
categories: linux mediaserver
published: false

---

A week ago I ordered computer parts on Amazon & built a completely new PC for my dad. His old PC had become so slow, it was unbearable.
It didn't have an SSD, so that explains a lot. But to be honest it wasn't just the HDD. His computer was just really, really old. His motherboard was still running legacy power, and his processor was pretty much done for too. So I decided to build him a new one.

I still had some parts laying around from my old computer that weren't completely outdated (Intel Core Duo E8400, a decent motherboard). So I decided to use the case and HDD from my dad's ancient computer and my old parts to create a Frankenstein media server. Turns out old computers with decent enough processors make freaking great media servers. I re-pasted the processor, cleaned it out a bit and it was up and running in minutes.

I'll go through the steps to make a simple home file server (accessible by Windows, Linux & macOS), that also allows for remote torrent downloading and can also be used to stream media on devices using Plex server.

# Choosing your operating system
This simple setup is most likely also possible on a Windows server OS, or any Linux server distribution, but I chose for **Ubuntu Server 16.04 LTS**, it's convenient, and Ubuntu is usually a tad easier to set up than other distributions like Arch Linux. 16.04 got released only months ago, and it's a long term support version, so that will also come in handy.

# Making an installation media
After you chose your preferred OS, you're gonna have to download the `.iso` file and create a bootable installation media.
You can easily install Linux distributions using UNetbootin, you can select the distribution from the dropdown, or you can choose your own ISO, I did the latter.

# Installing and setting up the OS
Reboot into the bootable media you just created, and run through the setup. Ubuntu server has a simple GUI setup so it shouldn't be that hard.
After the install finishes, you can boot back into your Ubuntu hard drive, and you'll be greeted with a simple terminal window. Ubuntu server doesn't ship with a GUI, to make the OS simple and fast. Just log in with your account and we'll get started by updating all of our packages:

```bash
$ sudo apt-get update
$ sudo apt-get upgrade
```

Now that that's out of the way, we'll set a static IP for the server, so we always know where to access it, we'll have to edit a config file for this. You can check out the current IP for your server by entering:

```bash
$ ifconfig
```

Keep note of your current IP (or a different one if you prefer), and your interface name.

Next you can edit the config file using your preferred text editor:

```bash
$ sudo vim /etc/network/interfaces
```

Using your own network settings, this is what your config file should look like:

```bash
auto eth0
iface eth0 inet static
  address 192.168.1.69
  netmask 255.255.255.0
  network 192.168.1.0
  broadcast 192.168.1.255
  gateway 192.168.1.1
```

Now we'll restart the network service.

```bash
$ sudo systemctl restart network
```

Once that's finished, we'll install all the extra packages we'll be using:

```bash
$ sudo apt-get install openssh-server smbclient cifs-utils ntp ntpdate
```

Time to create the directories we'll be sharing on the network, you're basically free to put these wherever, but I would recommend creating something like `/var/files` and having a some subdirectories in there, that's what i'll be doing.

```bash
$ sudo mkdir /var/files
$ sudo mkdir /var/files/public
$ sudo chmod 777 /var/files/public
# optional sticky bit, so a user can't delete other files
$ sudo chmod -t /var/files/public
```