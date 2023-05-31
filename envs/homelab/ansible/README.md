# ansible

This a simple Ansible playbook is for managing OS updates and k3s on the pie cluster. 

The playbook will ensure that all OS updates are installed on the nodes and that k3s is install as an HA cluster. The load balancer is configured outside of this. The pie disk images are Debian arm images that have been modified to add a specific private ssh key. 

To run the playbook first set the environment variable `K3S_TOKEN` to the correct value for the cluster. 

Example usage:

```
ansible-playbook -i hosts site.yaml
```


## lb configuration

Load balancing the api server is done using the nginx configuration below. Nodes 02 and 03 are set as backup, because our load balancer is will start sending traffic to nodes before they are ready. A health check would fix this, but free nginx does not support health checks. 

```
stream {
  upstream cluster {
    server pie01:6443;
    server pie02:6443 backup;
    server pie03:6443 bacukp;
  }

  server {
    listen 6443;
    proxy_pass cluster;
  }
}
```
