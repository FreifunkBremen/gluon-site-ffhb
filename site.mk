GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-respondd \
	respondd-module-airtime \
	respondd-module-wifisettings \
	gluon-respondd-lldp \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-ebtables-segment-mld \
	gluon-client-bridge \
	gluon-radv-filterd \
	gluon-radvd \
	gluon-neighbour-info \
	gluon-node-info \
	gluon-speedtest \
	gluon-status-page \
	iputils-ping6 \
	iwinfo \
	iptables \
	firewall \
	haveged \
	gluon-authorized-keys \
	ffhb-breminale \
	reghack

# Variables set with ?= can be overwritten from the command line
GLUON_RELEASE ?= $(patsubst v%,%,$(shell git -C $(GLUON_SITEDIR) describe --tags --dirty=+))
export GLUON_BRANCH ?= stable
GLUON_PRIORITY ?= 7
GLUON_LANGS ?= en de
GLUON_REGION ?= eu
GLUON_ATH10K_MESH ?= 11s
