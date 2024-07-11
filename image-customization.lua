features({
  'autoupdater',
  'config-mode-core',
  'config-mode-domain-select',
  'config-mode-geo-location',
  'config-mode-geo-location-osm',
  'ebtables-filter-multicast',
  'ebtables-filter-ra-dhcp',
  'ebtables-limit-arp',
  'mesh-batman-adv-15',
  'mesh-vpn-fastd',
  'radv-filterd',
  'respondd',
  'scheduled-domain-switch',
  'setup-mode',
  'speedtest',
  'ssid-changer',
  'status-page',
  'web-advanced',
  'web-mesh-vpn-fastd',
  'web-private-wifi',
  'web-wizard',
})

packages({
  'respondd-module-airtime',
  'iwinfo',
  'firewall',
  'urngd',
})

if not device_class('tiny') then
  features({
    'wireless-encryption-wpa3',
    'tls'
  })
end

if target('ramips','mt7621') then
  packages({
    '-respondd-module-airtime',
  })
end
