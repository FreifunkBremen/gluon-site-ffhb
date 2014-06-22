GLUON_SITE_PACKAGES := \
	gluon-alfred \
	gluon-autoupdater \
	gluon-config-mode \
	gluon-firewall \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-mesh-batman-adv \
	gluon-mesh-vpn-fastd \
	gluon-next-node \
	gluon-status-page \
	iputils-ping6 \
	iwinfo \
	iptables \
	kmod-ipt-nathelper \
	firewall \
	haveged

DEFAULT_GLUON_RELEASE := 0.3.102-nightly$(shell date '+%Y%m%d')

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
