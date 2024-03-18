# KOReader Docker Image

This image allows KOReader to be run within a docker container and accessible via a web browser.

## Usage

KOReader is accessible via the container port 8080. By default, KOReader opens the container's `/docs` directory.

For example, if you have books stored at `/home/user/books` and want to access KOReader using port 3000, run the following command:

```
docker run --rm -p 3000:8080 -v /home/user/books:/docs ghrc.io/whimsical-c4lic0/koreader:latest
```

Then open a web browser, and navigate to `http://localhost:3000`

## Image Contents

- [Alpine Linux](https://www.alpinelinux.org) - A lightweight Linux distribution to serve as the image base
- [noVNC](https://novnc.com) - An HTML5 canvas VNC viewer
- [supervisord](http://supervisord.org) - A process control system for managing the noVNC server
- [x11vnc](https://github.com/LibVNC/x11vnc) - A VNC server for X displays
- [Xvfb](https://x.org/releases/X11R7.7/doc/man/man1/Xvfb.1.xhtml) - Virtual framebuffer X server for X11
- [KOReader](http://koreader.rocks/) - A document viewer for E Ink devices

## Attributions

This image is based on the [noVNC image](https://github.com/psharkey/docker/tree/master/novnc) by Pat Sharkey ([@psharkey](https://github.com/psharkey)).

