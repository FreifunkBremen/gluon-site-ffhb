GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	respondd \
	status-page \
	web-advanced \
	web-wizard \
	mesh-batman-adv-14

GLUON_SITE_PACKAGES := \
	respondd-module-airtime \
	gluon-config-mode-core \
        gluon-web-mesh-vpn-fastd \
        gluon-web-private-wifi \
	gluon-radv-filterd \
	gluon-setup-mode \
	gluon-speedtest \
	iputils-ping6 \
	iwinfo \
	iptables \
	firewall \
	haveged \
	gluon-scheduled-domain-switch

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
GLUON_BRANCH ?= stable
GLUON_PRIORITY ?= 0
GLUON_DEPRECATED ?= upgrade
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_WLAN_MESH ?= ibss
GLUON_MULTIDOMAIN=1
