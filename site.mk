GLUON_SITE_PACKAGES := \
	gluon-mesh-babel \
	gluon-l3roamd \
	gluon-respondd \
	respondd-module-airtime \
	gluon-autoupdater \
	gluon-config-mode-core \
	gluon-config-mode-hostname \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-web-admin \
	gluon-web-autoupdater \
	gluon-web-wifi-config \
	gluon-web-network \
	gluon-client-bridge \
	gluon-radvd \
	gluon-setup-mode \
	gluon-speedtest \
	gluon-status-page \
	iputils-ping6 \
	iwinfo \
	iptables \
	gluon-iptables-clamp-mss-to-pmtu \
	babeldev \
	haveged \
	ffhb-breminale \
	gluon-authorized-keys \
	respondd-module-lldp \
	respondd-module-wifisettings \
	wifictld \
	respondd-module-wifictld \
	reghack

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
export GLUON_BRANCH ?= babel
GLUON_PRIORITY ?= 0
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_WLAN_MESH ?= 11s


# Debug packages
DEBUG_PACKAGES := \
	tcpdump

# x86-64
ifeq ($(GLUON_TARGET),x86-64)
GLUON_SITE_PACKAGES += \
	$(DEBUG_PACKAGES) \
	haveged
endif
