GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-alfred \
	gluon-respondd \
	gluon-autoupdater \
	gluon-config-mode-core \
	gluon-config-mode-hostname \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-mesh-vpn-fastd \
	gluon-luci-portconfig \
	gluon-luci-private-wifi \
	gluon-luci-wifi-config \
	gluon-mesh-vpn-fastd \
	gluon-next-node \
	gluon-radv-filterd \
	gluon-radvd \
	gluon-setup-mode \
	gluon-speedtest \
	gluon-status-page \
	gluon-wan-dnsmasq-static \
	iputils-ping6 \
	iwinfo \
	iptables \
	firewall \
	haveged

DEFAULT_GLUON_PRIORITY := 0

# Allow overriding the release number and languages from the command line
GLUON_PRIORITY ?= $(DEFAULT_GLUON_PRIORITY)
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_ATH10K_MESH ?= ibss
