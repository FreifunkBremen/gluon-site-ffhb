GLUON_FEATURES := \
	autoupdater \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	mesh-batman-adv-15 \
	mesh-vpn-fastd \
	respondd \
	status-page \
	web-advanced \
	web-wizard

GLUON_SITE_PACKAGES := \
	gluon-ssid-changer \
	respondd-module-airtime \
	gluon-config-mode-core \
	gluon-config-mode-domain-select \
	gluon-config-mode-geo-location \
	gluon-config-mode-geo-location-osm \
	gluon-web-mesh-vpn-fastd \
	gluon-web-private-wifi \
	gluon-radv-filterd \
	gluon-setup-mode \
	gluon-speedtest \
	iwinfo \
	firewall \
	urngd \
	gluon-scheduled-domain-switch

# Allow overriding the these variables from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell echo $(git -C $(GLUON_SITEDIR) describe --tags --abbrev=0))-build$(CI_PIPELINE_ID))))
GLUON_AUTOUPDATER_BRANCH ?= stable
GLUON_AUTOUPDATER_ENABLED ?= 1
GLUON_PRIORITY ?= 0
GLUON_DEPRECATED ?= upgrade
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_MULTIDOMAIN=1


EXCLUDE_NO_WIFI:= -respondd-module-airtime

# ramips-mt7621
ifeq ($(GLUON_TARGET),ramips-mt7621)
	GLUON_ubnt-erx_SITE_PACKAGES +=  $(EXCLUDE_NO_WIFI)
	GLUON_ubnt-erx-sfp_SITE_PACKAGES +=  $(EXCLUDE_NO_WIFI)
endif

