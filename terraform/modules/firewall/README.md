# Digital Ocean Firewall Module

Creates firewall rules with sources and tags.

## Firewalls

* external
    * inbound
        * ports: 443
            * sources: 0.0.0.0/0
        * ports: 22
            * sources: ssh
    * outbound
        * ports: all
* internal
    * inbound
        * ports: 443, 80
            * sources: external, internal
        * ports: 22
            * sources: ssh
    * outbound
        * ports: all
* whitelist
    * inbound
        * ports: all
            * sources: specific IPs
    * outbound
        * pots: all 
