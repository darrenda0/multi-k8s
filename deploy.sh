docker build -t darrenda/multi-client:latest -t darrenda/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t darrenda/multi-server:latest -t darrenda/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t darrenda/multi-worker:latest -t darrenda/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push darrenda/multi-client:latest
docker push darrenda/multi-server:latest
docker push darrenda/multi-worker:latest

docker push darrenda/multi-client:$SHA
docker push darrenda/multi-server:$SHA
docker push darrenda/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=darrenda/multi-server:$SHA
kubectl set image deployments/client-deployment client=darrenda/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=darrenda/multi-worker:$SHA

