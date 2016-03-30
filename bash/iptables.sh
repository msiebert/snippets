# drop all traffic to a host
for ip in $(dig $host +short | grep -P "\d+\.\d+\.\d+\.\d+"); do
  sudo iptables -A INPUT -s $ip -j DROP
done

# redirect all traffic to a host to a local port
for ip in $(dig $host +short | grep -P "\d+\.\d+\.\d+\.\d+"); do
  sudo iptables -t nat -A PREROUTING -d $ip -p tcp -j DNAT --to-destination 127.0.0.1:$port
  sudo iptables -t nat -A POSTROUTING -p tcp -s 127.0.0.1 --sport $port -j SNAT --to-source $ip
  sudo iptables -t nat -A OUTPUT -d $ip -p tcp -j DNAT --to-destination 127.0.0.1:$port
done

# restore ip tables
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

