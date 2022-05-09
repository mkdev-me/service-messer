

```
kubectl create ns mkdev
kubectl apply -f dp.yaml
```


### To build on M1

```
docker buildx build --platform linux/amd64 -f Containerfile .
```
