GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-respondd \
	respondd-module-airtime \
	gluon-autoupdater \
	gluon-config-mode-core \
	gluon-config-mode-hostname \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-ebtables-segment-mld \
	gluon-web-admin \
	gluon-web-autoupdater \
	gluon-web-mesh-vpn-fastd \
	gluon-web-network \
	gluon-web-private-wifi \
	gluon-web-wifi-config \
	gluon-mesh-vpn-fastd \
	gluon-radv-filterd \
	gluon-radvd \
	gluon-setup-mode \
	gluon-speedtest \
	gluon-status-page \
	iputils-ping6 \
	iwinfo \
	iptables \
	firewall \
	haveged

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
export GLUON_BRANCH ?= stable
GLUON_PRIORITY ?= 0
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_WLAN_MESH ?= ibss
