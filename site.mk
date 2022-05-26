GLUON_SITE_PACKAGES := \
	gluon-respondd \
	respondd-module-airtime \
	gluon-config-mode-core \
	gluon-config-mode-hostname \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-web-admin \
	gluon-web-network \
	gluon-web-wifi-config \
	gluon-client-bridge \
	gluon-setup-mode \
	gluon-speedtest \
	gluon-status-page \
	iwinfo \
	firewall \
	haveged \
	gluon-authorized-keys \
	respondd-wifi \
	respondd-module-wifisettings \
	respondd-module-interface-address \
	ffhb-breminale \
	reghack

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
GLUON_AUTOUPDATE_BRANCH ?= stabel
GLUON_AUTOUPDATER_ENABLED ?= 1
GLUON_PRIORITY ?= 0
GLUON_DEPRECATED ?= 0
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
