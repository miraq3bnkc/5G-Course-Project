Link για την ιστοσελιδά του να κατεβάσεις το artillery

https://www.artillery.io/docs/get-started/get-artillery

Για να τρέξει το load test και να φτιάξει report είναι το εξής (να το τρέξεις από το terminal του artillery φακέλου):

```shell
artillery run -o nginx-pseudo-streaming-report.json nginx-artillery-testing.yaml
```
Για να φτιάξει το html αρχείο, που φαίνεται καλύτερο τα στοιχεία

```shell
% artillery report nginx-pseudo-streaming-report.json 
```

# Scaling a Dockerized Nginx Video Streaming Service with Kubernetes

Αυτό το έργο δείχνει πώς να ρυθμίσετε μια υπηρεσία ροής βίντεο βασισμένη στο Nginx χρησιμοποιώντας το Minikube και το Kubernetes.

## Προαπαιτούμενα

- Πρέπει να είναι εγκατεστημένο και ρυθμισμένο το [Minikube](https://minikube.sigs.k8s.io/docs/start/).
- Πρέπει να είναι εγκατεστημένο το [Docker](https://docs.docker.com/get-docker/).

## Οδηγίες Εγκατάστασης

Ακολουθήστε τα παρακάτω βήματα για την ανάπτυξη της εφαρμογής σε ένα τοπικό Κubernetes cluster:

1. **Έναρξη του Minikube**:
    ```shell
    minikube start
    ```

2. **Ρυθμίστε το Docker να χρησιμοποιεί το Docker daemon του Minikube**:
    ```shell
    eval $(minikube -p minikube docker-env)
    ```

3. **Κατασκευάστε την εικόνα Docker**:
    - Κατασκευάστε την εικόνα Docker για την υπηρεσία ροής βίντεο με Nginx χρησιμοποιώντας το παρεχόμενο Dockerfile.
    ```shell
    docker build -t nginx-video-streaming .
    ```

4. **Εφαρμόστε την εφαρμογή (Deployment)**:
    - Εφαρμόστε το αρχείο `deployment.yaml` για να δημιουργήσετε την ανάπτυξη και το αρχείο `service.yaml` για να δημιουργήσετε την υπηρεσία.
    ```shell
    kubectl apply -f deployment.yaml
    kubectl apply -f service.yaml
    ```

5. **Τρέξτε το τούνελ του Minikube** :
    - Ξεκινήστε το τούνελ του Minikube για να επιτρέψετε πρόσβαση στην υπηρεσία από τον τοπικό σας υπολογιστή.Δημιουργεί μια external ip, που μπορει να χρησιμοποιηθει για τα load test. Θα πρέπει να τρέξετε αυτή την εντολή σε ξεχωριστό παράθυρο τερματικού για να διατηρήσει τον LoadBalancer σε λειτουργία. Μπορείτε να σταματησετε την διαδικασια με το πλήκτρο Ctrl-C .
    ```shell
    minikube tunnel
    ```

6. **Επαληθεύστε την υπηρεσία**:
    - Ελέγξτε την κατάσταση της υπηρεσίας. Στην στήλη "EXTERNAL-IP" θα βρείτε την IP διεύθυνση.
    ```shell
    kubectl get service
    ```

7. **Δοκιμαστική Χρήση Prometheus με Grafana για nginx metrics με nginx-prometheus-exporter**:
    - Δημιουργία του Prometheus Server, με την βοηθεια του [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md). Μετα την εγκατάσταση του operator κάνουμε deploy όλα τα manifest που χρειάζονται για την παρακολουθηση των nginx μετρικών που περιγραφονται και στην σελίδα του [nginx-prometheus-exporter](https://github.com/nginxinc/nginx-prometheus-exporter)
    
    - Deploy ενός manifest servicemonitor από την μερία του nginx 

    ```shell
    kubectl apply -f nginx-monitor.yaml
    ```
    - Deploy manifests από την μεριά του prometheus operator

    ```shell
    cd prometheus_operator
    kubectl apply -f prom_rbac.yaml
    kubectl apply -f prometheus-service.yaml
    kubectl apply -f prometheus.yaml
    ```
    Μπορούμε να συνδεθούμε στο Prometheus Server με localhost:[EXTERNAL-IP]:9090/ , όπου EXTERNAL-IP την βλέπουμε τρέχοντας την εντολή "kubectl get services" στο service "prometheus-service".

    - Deploy manifest ενος grafana server για την οπτικοποίηση των μετρικών που γίνονται scrape με γραφικές παραστάσεις. 

    ```shell
    cd ../grafana
    kubectl apply -f grafana.yaml
    ```
    όπου με τον ίδιο τρόπο που συνδεθήκαμε πριν στο prometheus , αντιστοιχα συνδεόμαστε στην θύρα 3000, default κωδικός και όνομα χρηση στο grafana είναι admin και admin

Τώρα έχετε μια πλήρως λειτουργική υπηρεσία ροής βίντεο με Nginx που τρέχει στο cluster σας με Minikube.

## Πρόσθετοι Πόροι

- [Τεκμηρίωση Minikube](https://minikube.sigs.k8s.io/docs/)
- [Τεκμηρίωση Kubernetes](https://kubernetes.io/docs/)
- [Τεκμηρίωση Docker](https://docs.docker.com/)

