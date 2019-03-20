docker build -t olegkariuk/multi-client:latest -t olegkariuk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olegkariuk/multi-server:latest -t olegkariuk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olegkariuk/multi-worker:latest -t olegkariuk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olegkariuk/multi-client:latest
docker push olegkariuk/multi-server:latest
docker push olegkariuk/multi-worker:latest

docker push olegkariuk/multi-client:$SHA
docker push olegkariuk/multi-server:$SHA
docker push olegkariuk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=olegkariuk/multi-server:$SHA
kubectl set image deployments/client-deployment client=olegkariuk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=olegkariuk/multi-worker:$SHA
