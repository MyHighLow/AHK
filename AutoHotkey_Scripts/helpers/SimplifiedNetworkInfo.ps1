# netsh interface ip show address | sed -E "s/Configuration for interface \`"(.*)\`"/\1/g" | sed -E "/(\s*DHCP enabled:|\s*InterfaceMetric:|\s*Gateway Metric:)/d" | sed -E "/^v/,/^\s$/d" | sed -E "/^Virtual/,/^\s$/d"
# get connected interfaces:
# netsh interface show interface | sed -E "/\S*\s*Connected/!d" | sed -E "s/(Enabled|Disabled|Dedicated)//g" | sed -E "s/^\s+//g" | sed -E "s/^Connected\s+//g"
# just simple addresses
# netsh interface ip show address | sed -E "s/Configuration for interface \`"(.*)\`"/\1/g" | sed -E "/(\s*DHCP enabled:|\s*InterfaceMetric:|\s*Gateway Metric:)/d"


netsh interface ip show address | sed -E "s/Configuration for interface \`"(.*)\`"/\1/g" | sed -E "/(\s*DHCP enabled:|\s*InterfaceMetric:|\s*Gateway Metric:)/d" | sed "1d"