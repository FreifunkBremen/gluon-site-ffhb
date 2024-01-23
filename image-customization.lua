features({
  'autoupdater',
  'ebtables-filter-multicast',
  'ebtables-filter-ra-dhcp',
  'ebtables-limit-arp',
  'mesh-batman-adv-15',
  'mesh-vpn-fastd',
  'respondd',
  'status-page',
  'web-advanced',
  'web-wizard',
})

packages({
  'gluon-ssid-changer',
  'respondd-module-airtime',
  'gluon-config-mode-core',
  'gluon-config-mode-domain-select',
  'gluon-config-mode-geo-location',
  'gluon-config-mode-geo-location-osm',
  'gluon-web-mesh-vpn-fastd',
  'gluon-web-private-wifi',
  'gluon-radv-filterd',
  'gluon-setup-mode',
  'gluon-speedtest',
  'iwinfo',
  'firewall',
  'urngd',
  'gluon-scheduled-domain-switch',
})

if not device_class('tiny') then
  features({
    'wireless-encryption-wpa3',
  })
  packages({
    'ca-bundle',
    'ca-certificates',
    'libustream-openssl',
  })
end

if target('ramips','mt7621') then
  packages({
    '-respondd-module-airtime',
  })
end
