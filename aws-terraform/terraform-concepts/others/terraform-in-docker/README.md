## Docker command
```Dockerfile
docker build -t terraform .
sudo docker run --rm -it -v "$PWD":"/home/terraform" terraform:latest bash
```

