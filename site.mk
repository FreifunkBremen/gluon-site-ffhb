GLUON_SITE_PACKAGES := \
	gluon-mesh-batman-adv-14 \
	gluon-alfred \
	gluon-respondd \
	gluon-autoupdater \
	gluon-config-mode-core \
	gluon-config-mode-hostname \
	gluon-config-mode-autoupdater \
	gluon-config-mode-mesh-vpn \
	gluon-config-mode-geo-location \
	gluon-config-mode-contact-info \
	gluon-ebtables-filter-ra-dhcp \
	gluon-luci-admin \
	gluon-luci-autoupdater \
	gluon-luci-mesh-vpn-fastd \
	gluon-luci-portconfig \
	gluon-luci-private-wifi \
	gluon-luci-wifi-config \
	gluon-mesh-vpn-fastd \
	gluon-next-node \
	gluon-radvd \
	gluon-setup-mode \
	gluon-speedtest \
	gluon-status-page \
	gluon-wan-dnsmasq-static \
	iputils-ping6 \
	iwinfo \
	iptables \
	firewall \
	haveged

DEFAULT_GLUON_PRIORITY := 0

# Allow overriding the release number and languages from the command line
GLUON_PRIORITY ?= $(DEFAULT_GLUON_PRIORITY)
GLUON_LANGS ?= en de

# packages needed for FAT32 via USB
USB_PACKAGES := \
	kmod-usb-core \
	kmod-usb2
	block-mount \
	kmod-fs-ext4 \
	kmod-fs-vfat \
	kmod-usb-storage  \
	kmod-usb-storage-extras  \
	blkid  \
	swap-utils  \
	kmod-nls-cp1250  \
	kmod-nls-cp1251  \
	kmod-nls-cp437  \
	kmod-nls-cp775  \
	kmod-nls-cp850  \
	kmod-nls-cp852  \
	kmod-nls-cp866  \
	kmod-nls-iso8859-1  \
	kmod-nls-iso8859-13  \
	kmod-nls-iso8859-15  \
	kmod-nls-iso8859-2  \
	kmod-nls-koi8r  \
	kmod-nls-utf8

# include USB packages on supporting devices
ifeq ($(GLUON_TARGET),ar71xx-generic)
	GLUON_TLWR1043_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_TLWR842_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_TLWDR4300_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_TLWR2543_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_WRT160NL_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_DIR825B1_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_DIR505A1_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_GLINET_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_WNDR3700_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_WZRHPG450H_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_WZRHPAG300H_SITE_PACKAGES := $(USB_PACKAGES)
	GLUON_ARCHERC7_SITE_PACKAGES := $(USB_PACKAGES)
endif

ifeq ($(GLUON_TARGET),mpc85xx-generic)
	GLUON_TLWDR4900_SITE_PACKAGES := $(USB_PACKAGES)
endif
