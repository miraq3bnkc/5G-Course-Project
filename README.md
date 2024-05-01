Link για την ιστοσελιδά του να κατεβάσεις το artillery

https://www.artillery.io/docs/get-started/get-artillery

Για να τρέξει το load test και να φτιάξει report είναι το εξής (να το τρέξεις από το terminal του artillery φακέλου):

% artillery run -o nginx-pseudo-streaming-report.json nginx-artillery-testing.yaml

Για να φτιάξει το html αρχείο, που φαίνεται καλύτερο τα στοιχεία

% artillery report nginx-pseudo-streaming-report.json 


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

5. **Λάβετε το URL της υπηρεσίας**:
    - Βρείτε το URL για την υπηρεσία ροής βίντεο με Nginx.
    ```shell
    minikube service nginx-video-streaming --url
    ```

6. **Επαληθεύστε την υπηρεσία**:
    - Ελέγξτε την κατάσταση της υπηρεσίας.
    ```shell
    kubectl get service
    ```

7. **Τρέξτε το τούνελ του Minikube** :
    - Ξεκινήστε το τούνελ του Minikube για να επιτρέψετε πρόσβαση στην υπηρεσία από τον τοπικό σας υπολογιστή.Δημιουργεί μια external ip, που μπορει να χρησιμοποιηθει για τα load test.
    ```shell
    minikube tunnel
    ```

Τώρα έχετε μια πλήρως λειτουργική υπηρεσία ροής βίντεο με Nginx που τρέχει στο cluster σας με Minikube.

## Πρόσθετοι Πόροι

- [Τεκμηρίωση Minikube](https://minikube.sigs.k8s.io/docs/)
- [Τεκμηρίωση Kubernetes](https://kubernetes.io/docs/)
- [Τεκμηρίωση Docker](https://docs.docker.com/)

