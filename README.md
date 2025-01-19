# GDC Client Docker Image

Docker Image available at Docker Hub: [rahit/gdc-client](https://hub.docker.com/r/rahit/gdc-client).

This is source code for a Docker image for GDC client with Mamba base image. The gdc-client provides several convenience functions for uploading/downloading via HTTPS at the gdc data portal.

## Usage

Run the container with the following command:
```bash
docker run -it --rm --name gdc-client -v $(pwd):/data -w /data gdc-client:latest
```

### Build

```bash
docker build -t gdc-client:latest .
```
