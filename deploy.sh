docker build -t mappiani/multi-client:latest -t mappiani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mappiani/multi-server:latest -t mappiani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mappiani/multi-worker:latest -t mappiani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mappiani/multi-client:latest
docker push mappiani/multi-client:$SHA
docker push mappiani/multi-server:latest
docker push mappiani/multi-server:$SHA
docker push mappiani/multi/worker:latest
docker push mappiani/multi/worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mappiani/multi-server:$SHA
kubectl set image deployments/client-deployment client=mappiani/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mappiani/multi-worker:$SHA
