#create amazonlinux ec2 with t2.micro and 30 gb of ebs with port 8081 

sudo yum update -y
sudo yum install wget -y
yum install java-17-amazon-corretto -y
sudo mkdir /app && cd /app
sudo wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.79.0-09.tar.gz
sudo tar -zxvf nexus-unix-x86-64-3.79.0-09.tar.gz
sudo useradd nexus
sudo chown -R nexus:nexus nexus-3.79.0-09 sonatype-work
sudo echo "run_as_user="nexus"" > /app/nexus/bin/nexus.rc
sudo tee /etc/systemd/system/nexus.service > /dev/null << EOL
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOL
sudo chkconfig nexus on
sudo systemctl start nexus
sudo systemctl status nexus

