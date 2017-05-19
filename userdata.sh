sudo echo nameserver 10.232.13.14 > /etc/resolv.conf

# Install TrendMicro
echo "INFO: getting trendmicro package"
sudo wget https://app.deepsecurity.trendmicro.com/software/agent/Ubuntu_14.04/x86_64/agent.deb
echo "INFO: installing trendmicro package"
sudo dpkg -i agent.deb
echo "INFO: enabling ds_agent"
sleep 5
sudo /opt/ds_agent/dsa_control -r
sudo /opt/ds_agent/dsa_control -a dsm://dshb.nike.com:4120/ "policyid:32"


