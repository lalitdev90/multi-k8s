docker build -t lalitdev90/multi-client:latest -t lalitdev90/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lalitdev90/multi-server:latest -t lalitdev90/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lalitdev90/multi-worker:latest -t lalitdev90/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lalitdev90/multi-client:latest
docker push lalitdev90/multi-server:latest
docker push lalitdev90/multi-worker:latest

docker push lalitdev90/multi-client:$SHA
docker push lalitdev90/multi-server:$SHA
docker push lalitdev90/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=lalitdev90/multi-server:$SHA
kubectl set image deployments/client-deployments client=lalitdev90/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=lalitdev90/multi-worker:$SHA
