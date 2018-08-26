# Digital Ocean Firewall Module

Creates firewall rules with sources and tags.

## Ports and Sources

* public
    * Ports: 443
    * Sources: All
* restricted
    * Ports: 443, 8000
    * Sources: public, restricted, internal, specific IPs and ranges
* ssh
    * Ports: 22
    * sources: ssh tags and specific IPs and ranges
