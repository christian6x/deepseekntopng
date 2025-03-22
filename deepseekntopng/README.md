## Opis Helm Chartu: `ntopngpack`

Ten Helm Chart służy do wdrożenia kompleksowego rozwiązania monitorowania ruchu sieciowego, składającego się z następujących komponentów:

1. **ntopng** – narzędzie do analizy ruchu sieciowego w czasie rzeczywistym.
2. **Redis** – baza danych używana przez ntopng do przechowywania danych.
3. **NetFlow2NG** – narzędzie do zbierania i przesyłania danych NetFlow do ntopng.

### Wymagania

- Kubernetes 1.19+
- Helm 3.0+
- Dostęp do PersistentVolume (PV) dla Redis i ntopng (opcjonalnie).

### Instalacja

1. **Dodaj repozytorium Helm** (jeśli chart jest hostowany w repozytorium):

   ```bash
   helm repo add deepseekntopng https://raw.githubusercontent.com/christian6x/deepseekntopng/main/
   helm repo update
   ```

2. **Zainstaluj chart**:

   ```bash
   helm install test deepseekntopng/deepseekntopng --namespace test --create-namespace --set netflow2ng.service.loadBalancerIP=192.168.88.224 --set ntopng.service.loadBalancerIP=192.168.88.225
   ```

    - **`home`**: Nazwa release'u Helm. Możesz ją dostosować do swoich potrzeb.
    - **`--namespace test`**: Namespace, w którym zostaną wdrożone zasoby. Jeśli namespace nie istnieje, zostanie utworzony dzięki fladze `--create-namespace`.
    - **`--create-namespace`**: Tworzy namespace `ntopng`, jeśli nie istnieje.
    - **`--set netflow2ng.service.loadBalancerIP=192.168.88.224`**: Ustawia statyczny adres IP dla LoadBalancera NetFlow2NG na `192.168.88.224`.
    - **`--set ntopng.service.loadBalancerIP=192.168.88.225`**: Ustawia statyczny adres IP dla LoadBalancera ntopng na `192.168.88.225`.


### Konfiguracja

Wszystkie parametry konfiguracyjne są zdefiniowane w pliku `values.yaml`. Oto najważniejsze z nich:

#### Redis

- **`redis.enabled`**: Włącza/wyłącza wdrożenie Redis (domyślnie: `true`).
- **`redis.image`**: Obraz Dockera dla Redis (domyślnie: `redis:latest`).
- **`redis.service.port`**: Port serwisu Redis (domyślnie: `6379`).
- **`redis.pvc.enabled`**: Włącza/wyłącza PersistentVolumeClaim (PVC) dla Redis (domyślnie: `true`).
- **`redis.pvc.storage`**: Rozmiar PVC dla Redis (domyślnie: `1Gi`).

#### ntopng

- **`ntopng.enabled`**: Włącza/wyłącza wdrożenie ntopng (domyślnie: `true`).
- **`ntopng.image`**: Obraz Dockera dla ntopng (domyślnie: `ntop/ntopng:latest`).
- **`ntopng.httpPort`**: Port HTTP dla ntopng (domyślnie: `3000`).
- **`ntopng.service.loadBalancerIP`**: Statyczny adres IP dla LoadBalancer (opcjonalnie).
- **`ntopng.pvc.enabled`**: Włącza/wyłącza PVC dla ntopng (domyślnie: `true`).
- **`ntopng.pvc.storage`**: Rozmiar PVC dla ntopng (domyślnie: `10Gi`).

#### NetFlow2NG

- **`netflow2ng.enabled`**: Włącza/wyłącza wdrożenie NetFlow2NG (domyślnie: `true`).
- **`netflow2ng.image`**: Obraz Dockera dla NetFlow2NG (domyślnie: `synfinatic/netflow2ng:latest`).
- **`netflow2ng.input.address`**: Adres nasłuchiwania dla NetFlow (domyślnie: `192.168.88.224`).
- **`netflow2ng.input.port`**: Port nasłuchiwania dla NetFlow (domyślnie: `2055`).

### Użycie

Po zainstalowaniu chartu możesz uzyskać dostęp do ntopng przez adres IP LoadBalancer lub przez port-forwarding:

```bash
kubectl port-forward svc/my-release-ntopng-service 3000:3000 --namespace my-namespace
```

Następnie otwórz przeglądarkę i przejdź do `http://localhost:3000`.

### Aktualizacja

Aby zaktualizować wdrożenie, użyj polecenia:

```bash
helm upgrade my-release ./ntopngpack --namespace my-namespace
```

### Usuwanie

Aby usunąć wdrożenie, użyj polecenia:

```bash
helm uninstall my-release --namespace my-namespace
```

### Wsparcie

Jeśli masz pytania lub problemy, skontaktuj się z autorem chartu lub zgłoś issue w repozytorium.

---

### Struktura katalogów

```
ntopngpack/
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

---

### Informacja o generowaniu

Ten Helm Chart został wygenerowany przy użyciu **DeepSeek**.

---

### Licencja

Ten Helm Chart jest dostępny na licencji [MIT](LICENSE).


