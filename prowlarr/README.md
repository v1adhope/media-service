# Prowlarr

## Custom indexers

The bundled [custom indexer definitions](config/Definitions/Custom) are available through the configuration volume defined in [Prowlarr's Compose file](compose.yml).

| Definition | Content |
| --- | --- |
| [1337x](config/Definitions/Custom/1337x.yml) | Movies and TV |
| [EZTV](config/Definitions/Custom/eztv.yml) | TV shows |
| [Nyaa.si](config/Definitions/Custom/nyaasi.yml) | Anime |

Find more definitions in [Prowlarr/Indexers](https://github.com/Prowlarr/Indexers/tree/master).

After adding or editing definitions, restart Prowlarr to clear cached definitions; see the [service commands](../README.md#common-commands).

In Prowlarr, open **Indexers → Add Indexer**, search for the indexer name, configure its settings, then test and save. The YAML files define how to query each site; indexer instances still need to be added in the web interface.

For outgoing requests, configure the [shared HTTP proxy](../flaresolverr/README.md#shared-http-proxy).

## FlareSolverr indexer proxy

Open **Settings → Indexer Proxies → + → FlareSolverr**. For the Host, use an HTTP URL built from the service name and listening port in [FlareSolverr's Compose configuration](../flaresolverr/compose.yml). Assign the same tag to this proxy and the indexers that should use it, then test and save.

Prowlarr reaches FlareSolverr over the shared Docker network. Its API handles browser challenges; outgoing HTTP requests use the separate [shared HTTP proxy settings](../flaresolverr/README.md#shared-http-proxy).

For FlareSolverr's outgoing proxy and v2rayA routing rules, see the [FlareSolverr README](../flaresolverr/README.md).
