# Log content auto-discovery

The Dynatrace OneAgent can auto-discover logs if they meet certain requirements as explained in the [Dynatrace Docs](https://www.dynatrace.com/support/help/how-to-use-dynatrace/log-monitoring/log-monitoring-v2/log-content-auto-discovery-v2).

![image](images/log-agent.png)

# Example Prereqs

The examples below require the following:

1. Dynatrace Environment 
1. Virtual Machine with Ubuntu O/S, OneAgent installed, and Docker as to start a sample application
1. Start up the sample application
1. Enable log capture

## Virtual Machine setup 

1. VM running Ubuntu 20.04 LTS with a public IP and 2 CPU and 8 GM memory (for example: Azure Standard D2as v4)
1. Open port 22 for SSH access 
1. On the VM, run the following commands to install Docker

    ```
    # install docker
    # Reference: https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    # review installation
    docker version
    sudo systemctl status docker
    ```

## Startup the Sample application 

A sample application written in NodeJS in the `logapp/` directory will just loop to make logs.  This application was published as a Docker image as to make it easy to run.

### Start 

```
cd ~
docker run -it -e LOOPS=1000 -e LOGFILE=/mount/applog.log -v $(pwd):/mount dtdemos/logapp:1.0.0 
```

### Verify Logs are being created

```
tail ~/applog.log
```

## Enable log capture

Now that the application is running, we need to enable the log capture.

1. Goto the `Host` menu in Dynatrace and open up the host
1. On the host page, click to open the `logapp.sh` Node process
1. On the process page, click the `Configure more logs` button on the logs section on the right side
1. Add the full path to the `logapp.log` and save.  For example: `/home/azureuser/logapp.js`
1. Goto `Settings -> Log Monitoring -> Log sources and storage`
1. Find the host and the `logapp.js` process group
1. Enable the `logapp.log` log file for capture

# View Logs

View the logs within the `Observe and explore -> Logs` page within Dynatrace as shown below and filter if required to the `logapp.log` file.

![image](images/logview.png)

# Stop the sample app 

```
# get docker process id
sudo docker ps
# stop and remove process
sudo docker stop <process id>
sudo docker rm <process id>

```