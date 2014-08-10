GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-alfred \
	gluon-announced \
	gluon-ath9k-workaround \
	gluon-autoupdater \
	gluon-config-mode-hostname \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-private-wifi \
	gluon-mesh-vpn-fastd \
	gluon-next-node \
	gluon-status-page \
	gluon-wan-dnsmasq-static \
	iputils-ping6 \
	iwinfo \
	iptables \
	kmod-ipt-nathelper \
	firewall \
	haveged

DEFAULT_GLUON_RELEASE := 0.5~testing4-nightly$(shell date '+%Y%m%d')
DEFAULT_GLUON_PRIORITY := 0

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_PRIORITY ?= $(DEFAULT_GLUON_PRIORITY)
