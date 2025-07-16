Start a Novetus server using Docker:

```bash
docker run -d \
  --name=novetus \
  --restart always \
  -p 53640:53640/udp \
  -p 127.0.0.1:3000:3000 `# Optional: Track connected players on the server, it is heavely recommended to put this behind a reverse proxy.` \
  -e CLIENT=2012M `# Optional: Select the client version (default: 2012M)` \
  -e MAXPLAYERS=12 `# Optional: Set maximum number of players` \
  -e PORT=53640 `# Optional: Change the server port` \
  -e MAP="Z:\\default.rbxl" `# Optional: Set the map path inside the container` \
  -v ./mymap.rbxl:/default.rbxl `# Optional: Mount a custom map` \
  novetus
```

---

## Supported Clients

| Version Code | Description |
| ------------ | ----------- |
| 2012M        | **Default** |
| 2011M        | Supported   |
| 2011E        | Supported   |
| 2010L        | Supported   |
| 2009L        | Supported   |
| 2009E        | Supported   |
| 2008M        | Supported   |

