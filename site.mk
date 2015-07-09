GLUON_SITE_PACKAGES := \
	ffhb-breminale \
	gluon-alfred \
	gluon-authorized-keys \
	iputils-ping6 \
	iwinfo \
	iptables \
	kmod-ipt-nathelper \
	firewall \
	haveged

DEFAULT_GLUON_RELEASE := 2015.1.1+breminale1
DEFAULT_GLUON_PRIORITY := 0

# Allow overriding the release number and languages from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_PRIORITY ?= $(DEFAULT_GLUON_PRIORITY)
GLUON_LANGS ?= en de
