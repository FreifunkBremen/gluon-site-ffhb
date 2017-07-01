GLUON_SITE_PACKAGES := \
	gluon-mesh-babel \
	gluon-l3roamd \
	gluon-respondd \
	respondd-module-airtime \
	respondd-module-wifisettings \
	gluon-respondd-lldp \
	gluon-client-bridge \
	gluon-radvd \
	gluon-neighbour-info \
	gluon-node-info \
	gluon-speedtest \
	gluon-status-page \
	tcpdump \
	iputils-ping6 \
	iwinfo \
	iptables \
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
