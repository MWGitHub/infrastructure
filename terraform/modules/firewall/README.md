# Digital Ocean Firewall Module

Creates firewall rules with sources and tags.

## Firewalls

* public
    * inbound
        * ports: 443
            * sources: 0.0.0.0/0
        * ports: 22
            * sources: ssh
    * outbound
        * ports: all
* restricted
    * inbound
        * ports: 443, 80
            * sources: public, restricted
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
