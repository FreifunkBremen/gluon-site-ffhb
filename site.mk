GLUON_FEATURES := \
       respondd \
       status-page
#TODO ebtables... ?

GLUON_SITE_PACKAGES := \
	respondd-module-airtime \
	gluon-config-mode-core \
	gluon-config-mode-hostname \
	gluon-config-mode-contact-info \
	gluon-config-mode-geo-location \
	gluon-client-bridge \
	gluon-speedtest \
	iwinfo \
	firewall \
	haveged \
	gluon-authorized-keys
#TODO iptables ?
#TODO iputils-ping6 ?

# own packages
# just for easy find
GLUON_SITE_PACKAGES += \
	ffhb-breminale \
	respondd-wifi \
	respondd-module-wifisettings \
	respondd-module-interface-address \
	reghack \
	tcpdump
#TODO disabled, till fixed:
#       respondd-module-lldp \

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
GLUON_AUTOUPDATE_BRANCH ?= stable
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
	$(DEBUG_PACKAGES)
endif
