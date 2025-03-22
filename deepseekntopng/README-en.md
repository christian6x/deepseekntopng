## Helm Chart Description: `deepseekntopng`

This Helm Chart is used to deploy a comprehensive network traffic monitoring solution, consisting of the following components:

1. **ntopng** – A real-time network traffic analysis tool.
2. **Redis** – A database used by ntopng to store data.
3. **NetFlow2NG** – A tool for collecting and forwarding NetFlow data to ntopng.

### Requirements

- Kubernetes 1.19+
- Helm 3.0+
- Access to PersistentVolume (PV) for Redis and ntopng (optional).

## Requirements in the Kubernetes Cluster

To deploy `deepseekntopng` in a Kubernetes cluster, a `LoadBalancer` service type must be configured. The `LoadBalancer` service provides external access to ntopng via a public IP address. Ensure that your Kubernetes cluster supports this functionality (e.g., in a public cloud or with a LoadBalancer module like MetalLB in an on-premise environment).

### Installation

1. **Add the Helm repository** (if the chart is hosted in a repository):

   ```bash
   helm repo add deepseekntopng https://raw.githubusercontent.com/christian6x/deepseekntopng/main/
   helm repo update
   ```

2. **Install the chart**:

   ```bash
   helm install test deepseekntopng/deepseekntopng --namespace test --create-namespace --set netflow2ng.service.loadBalancerIP=192.168.88.224 --set ntopng.service.loadBalancerIP=192.168.88.225
   ```

    - **`test`**: The name of the Helm release. You can customize it to your needs.
    - **`--namespace test`**: The namespace where the resources will be deployed. If the namespace does not exist, it will be created using the `--create-namespace` flag.
    - **`--create-namespace`**: Creates the `ntopng` namespace if it does not exist.
    - **`--set netflow2ng.service.loadBalancerIP=192.168.88.224`**: Sets a static IP address for the NetFlow2NG LoadBalancer to `192.168.88.224`.
    - **`--set ntopng.service.loadBalancerIP=192.168.88.225`**: Sets a static IP address for the ntopng LoadBalancer to `192.168.88.225`.

### Configuration

All configuration parameters are defined in the `values.yaml` file. Here are the most important ones:

#### Redis

- **`redis.enabled`**: Enables/disables Redis deployment (default: `true`).
- **`redis.image`**: Docker image for Redis (default: `redis:latest`).
- **`redis.service.port`**: Redis service port (default: `6379`).
- **`redis.pvc.enabled`**: Enables/disables PersistentVolumeClaim (PVC) for Redis (default: `true`).
- **`redis.pvc.storage`**: PVC size for Redis (default: `1Gi`).

#### ntopng

- **`ntopng.enabled`**: Enables/disables ntopng deployment (default: `true`).
- **`ntopng.image`**: Docker image for ntopng (default: `ntop/ntopng:latest`).
- **`ntopng.httpPort`**: HTTP port for ntopng (default: `3000`).
- **`ntopng.service.loadBalancerIP`**: Static IP address for the LoadBalancer (optional).
- **`ntopng.pvc.enabled`**: Enables/disables PVC for ntopng (default: `true`).
- **`ntopng.pvc.storage`**: PVC size for ntopng (default: `10Gi`).

#### NetFlow2NG

- **`netflow2ng.enabled`**: Enables/disables NetFlow2NG deployment (default: `true`).
- **`netflow2ng.image`**: Docker image for NetFlow2NG (default: `synfinatic/netflow2ng:latest`).
- **`netflow2ng.input.address`**: Listening address for NetFlow (default: `192.168.88.224`).
- **`netflow2ng.input.port`**: Listening port for NetFlow (default: `2055`).

### Usage

After installing the chart, you can access ntopng via the LoadBalancer IP or through port-forwarding:

```bash
kubectl port-forward svc/my-release-ntopng-service 3000:3000 --namespace my-namespace
```

Then, open your browser and navigate to `http://localhost:3000`.

### Updating

To update the deployment, use the following command:

```bash
helm upgrade my-release ./deepseekntopng --namespace my-namespace
```

### Uninstallation

To uninstall the deployment, use the following command:

```bash
helm uninstall my-release --namespace my-namespace
```

### Support

If you have any questions or issues, please contact the chart author or open an issue in the repository.

---

### Directory Structure

```
deepseekntopng/
├── Chart.yaml
├── values.yaml
├── README.md
├── templates/
│   ├── redis-deployment.yaml
│   ├── redis-service.yaml
│   ├── redis-pvc.yaml
│   ├── ntopng-deployment.yaml
│   ├── ntopng-service.yaml
│   ├── ntopng-pvc.yaml
│   ├── netflow2ng-deployment.yaml
│   ├── netflow2ng-service.yaml
│   └── _helpers.tpl
```

## Tools Used

This project utilizes code from the [netflow2ng](https://github.com/synfinatic/netflow2ng) repository, which is used for parsing and processing NetFlow data. We thank the authors for their contribution to the development of network traffic analysis tools.

---

### Generation Information

This Helm Chart was generated using **DeepSeek**.

---

### License

This Helm Chart is available under the [MIT License](LICENSE).

