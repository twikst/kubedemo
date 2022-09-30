# Original: https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/install-containerd-on-ubuntu-22-04.html

# Install Containerd
wget 'https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz'
sudo tar Czxf /usr/local containerd-1.6.8-linux-amd64.tar.gz
wget 'https://raw.githubusercontent.com/containerd/containerd/main/containerd.service'
sudo mv containerd.service /usr/lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
# sudo systemctl status containerd

# Install runC
wget 'https://github.com/opencontainers/runc/releases/download/v1.1.4/runc.amd64'
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

# Containerd configuration for Kubernetes
sudo mkdir -p /etc/containerd/
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Install CNI Plugins For Containerd
sudo mkdir -p /opt/cni/bin/
sudo wget 'https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz'
sudo tar Cxzf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

# Restart the Containerd service
sudo systemctl restart containerd

# Install nerdctl (CLI)
wget 'https://github.com/containerd/nerdctl/releases/download/v0.23.0/nerdctl-0.23.0-linux-amd64.tar.gz'
sudo tar Cxzf /usr/local/bin nerdctl-0.23.0-linux-amd64.tar.gz
