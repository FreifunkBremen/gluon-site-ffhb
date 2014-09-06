GLUON_SITE_PACKAGES := \
	gluon-alfred \
	gluon-announced \
	gluon-ath9k-workaround \
	gluon-autoupdater \
	gluon-channel-survey \
	gluon-config-mode \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-mesh-batman-adv \
	gluon-luci-private-wifi \
	gluon-mesh-vpn-fastd \
	gluon-next-node \
	gluon-speedtest \
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
