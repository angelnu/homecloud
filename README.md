## Home Cloud deplyoment based on Kubernetes, iobroker and ansible

Creates/Updates my private cloud based on Kubernetes and deploy my services on it.

- Support HA Kubernetes cluster on hybrid architectures (I run masters on K8S and a big worker on Intel)
- Many services: see the [services](services) folder
  - [Iobroker](https://github.com/ioBroker/ioBroker) for home automation
  - Ingress based on [Traefik](https://traefik.io/)
  - K8S monitoring with Grafana
  - cifs (samba) mounts
  - rebalancing of nodes based on [Kubernetes descheduler](https://github.com/kubernetes-incubator/descheduler)
  - Use Glusterfs for persistent volumes (see gluster service)
  - keepalived for load balancing between the Kubernetes nodes
  - mail server based on exim4
  - openvpn client for multiple pods to share the same vpn Server
  - [Nextcloud](https://nextcloud.com/)
  - [Tiny Tiny RSS](https://tt-rss.org/)

## HW List

Here is the hardware you will need to complete the project:

| Amount | Part | Price |
| ------ | ---- | ----- |
| 3 | [Odroid HC1 - Home Cloud 1](http://www.hardkernel.com/main/products/prdt_info.php?g_code=G150229074080) | [3 * 59,95 EUR](https://www.pollin.de/p/odroid-hc1-einplatinen-computer-fuer-nas-und-cluster-anwendungen-810766) |
| 3 | [Micro SD Card 32 GB](http://amzn.eu/5IMqzRx) | 5 * 11 EUR |
| 3 | [ODROID BACKUP BATTERY](https://www.pollin.de/p/odroid-backup-battery-810319) | 3x 3,95 EUR |
| 3 | [ODROID Power Supply](https://www.pollin.de/p/steckernetzteil-xing-yuan-xy-0504000-e-5-v-4-a-351773) | 3x 9,95 EUR |


## Setup

See [commands](commands.md)


## References

Inspired by [Sergio Sisternes](https://github.com/sesispla/kubernetes-raspberry-pi)'s project.
