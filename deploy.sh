docker build -t peterlubbs/multi-client:latest -t peterlubbs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peterlubbs/multi-api:latest - peterlubbs/multi-api:$SHA -f ./api/Dockerfile ./api
docker build -t peterlubbs/multi-worker:latest -t peterlubbs/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push peterlubbs/multi-client:latest
docker push peterlubbs/multi-api:latest
docker push peterlubbs/multi-worker:latest
docker push peterlubbs/multi-client:$SHA
docker push peterlubbs/multi-api:$SHA
docker push peterlubbs/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=peterlubbs/multi-client:$SHA
kubectl set image deployments/api-deployment api=peterlubbs/multi-api:$SHA
kubectl set image deployments/worker-deployment worker=peterlubbs/multi-worker:$SHA