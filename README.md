nodeclub for docker

# Quick Start

```
docker run -it -p 3000:3000 wangmuy/nodeclub
```

# Persistent Data

```
docker run -it -p 3000:3000 -v /home/wangmuy/nodeclub:/var/lib/nodeclub -v /home/wangmuy/mongodb:/var/lib/mongodb -v /home/wangmuy/redis:/var/lib/redis wangmuy/nodeclub
```

