# Docker Samples

```bash
cd ls/
./build.sh
docker run ls:latest

cd source-env/
./build.sh
docker run source-env:latest

cd inject-env/
./build.sh
docker run --env EXTERNAL_APP=MYAPP inject-env:latest
```
