GLUON_SITE_PACKAGES := \
	gluon-alfred \
	gluon-client-bridge \
	gluon-respondd \
	gluon-respondd-airtime \
	gluon-respondd-clients \
	gluon-respondd-lldp \
	gluon-respondd-wifisettings \
	gluon-ebtables-filter-ra-dhcp \
	gluon-ebtables-filter-multicast \
	gluon-node-info \
	gluon-authorized-keys \
	iputils-ping6 \
	iwinfo \
	iptables \
	firewall \
	ffhb-breminale \
	reghack \
	haveged

DEFAULT_GLUON_RELEASE := 2016-breminale1
DEFAULT_GLUON_PRIORITY := 0

# Allow overriding the release number and languages from the command line
GLUON_PRIORITY ?= $(DEFAULT_GLUON_PRIORITY)
GLUON_LANGS ?= en de
