## Requirements (on Mac)

```bash
brew install minikube
minikube start --driver=docker # Start Minikube
kubectl get nodes # Verify the cluster

kubectl create namespace argocd # Create a Namespace for Argo CD:
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml # Install Argo CD (This command deploys Argo CD into the argocd namespace)
kubectl get pods -n argocd # Verify the Installation (Wait until all pods are in the Running state)

brew install argocd # Install the Argo CD CL
argocd version # Verify the Installation
kubectl port-forward svc/argocd-server -n argocd 8080:443 # Access the Argo CD API Server (Argo CD runs an API server inside the Kubernetes cluster. To access it)

argocd admin initial-password -n argocd # Login to Argo CD (Get the Initial Password)
argocd login localhost:8080 --username admin --password <INITIAL_PASSWORD> --insecure # Replace <INITIAL_PASSWORD> with the password you retrieved.
argocd account update-password # Change the Admin Password (Recommended)
```

## build docker image and run container

도커 이미지를 Docker Hub에서 받지 않고 로컬에서 생성한 이미지를 사용하게 하기 위해서 아래 옵션을 사용함

```
imagePullPolicy: IfNotPresent
```

argocd 에서 사용할 docker image 생성해둠 (local용)

```bash
docker build -t yourusername/nextjs-app:latest .
docker images # docker image 확인
docker run -p 3000:3000 yourusername/nextjs-app:latest
```

## local에서 argocd 실행하기

끝에 `&`을 붙이면 background에서 실행된다.
`localhost:8080`으로 들어가보면 argocd ui를 사용할 수 있다.

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443 &
```

## argocd 앱 리스트

```bash
argocd app list
```


## argocd app 생성 및 sync

- repo: 배포할 애플리케이션 깃헙경로
- path: manifest yaml file 디렉토리 경로 (k8s/deployment.yaml)
- dest-server: 
- dest-namespace:

```bash
argocd app create nextjs-app \
    --repo https://github.com/devstefancho/nextjs-app-for-argocd.git \
    --path k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace default

argocd app sync nextjs-app
```

```bash
kubectl get deployments
kubectl get services # 서비스명 확인
```


## app 삭제
```bash
argocd app delete nextjs-app
```


## kubectl 로 port-forward

80번 포트에 실행된 app을 로컬에서 3000번 포트로 접속할 수 있다.

```bash
kubectl port-forward svc/nextjs-app-service 3000:80
```

## kubectl 기타 명령어

```bash
kubectl get pods # pod 리스트 확인
kubectl get svc # 서비스명 확인 (kubectl get services와 동일함)
```

