docker build -t jhnny55/multi-client:latest -t jhnny55/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jhnny55/multi-server:latest -t jhnny55/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jhnny55/multi-worker:latest -t jhnny55/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jhnny55/multi-client:latest
docker push jhnny55/multi-server:latest
docker push jhnny55/multi-worker:latest

docker push jhnny55/multi-client:$SHA
docker push jhnny55/multi-server:$SHA
docker push jhnny55/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jhnny55/multi-server:$SHA
kubectl set image deployments/client-deployment client=jhnny55/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jhnny55/multi-worker:$SHA