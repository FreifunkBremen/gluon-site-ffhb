GLUON_FEATURES := \
        autoupdater \
        mesh-babel \
        mesh-vpn-wireguard \
	respondd \
	status-page \
        web-advanced \
        web-wizard

GLUON_SITE_PACKAGES := \
	gluon-l3roamd \
	respondd-module-airtime \
	gluon-config-mode-core \
	gluon-client-bridge \
	gluon-setup-mode \
	gluon-speedtest \
	iputils-ping6 \
	iwinfo \
	iptables \
	gluon-iptables-clamp-mss-to-pmtu \
	babeldev \
	haveged

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
export GLUON_BRANCH ?= babel
GLUON_PRIORITY ?= 0
GLUON_DEPRECATED ?= upgrade
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_WLAN_MESH ?= 11s

# Debug packages
DEBUG_PACKAGES := \
	tcpdump

# x86-64
ifeq ($(GLUON_TARGET),x86-64)
GLUON_SITE_PACKAGES += \
	$(DEBUG_PACKAGES)
endif
