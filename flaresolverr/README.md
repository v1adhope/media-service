# FlareSolverr and proxy settings

## Shared HTTP proxy

Each component that needs proxied access must configure its own outgoing proxy. Use the endpoint defined by `PROXY_URL` in [FlareSolverr's Compose configuration](compose.yml) as the shared HTTP proxy endpoint.

For Radarr, Sonarr, and Prowlarr, open **Settings → General → Proxy** (enable **Show Advanced** if needed), then enter:

| Setting | Value |
| --- | --- |
| Use Proxy | Enabled |
| Proxy Type | HTTP(S) |
| Hostname | Hostname from the linked proxy endpoint, without `http://` |
| Port | Port from the linked proxy endpoint |
| Username | Leave blank unless the proxy requires authentication |
| Password | Leave blank unless the proxy requires authentication |
| Ignored Addresses | Leave blank |
| Bypass Proxy for Local Addresses | Enabled |

Save the settings in each application. [Local-address bypass](https://github.com/Servarr/Wiki/blob/master/sonarr/settings.md#proxy) covers Docker service names, `localhost`, and loopback addresses. Clear any existing Ignored Addresses entries so external requests reach the shared proxy and follow the [v2rayA routing rules](#v2raya-routing-rules). Ignored addresses are patterns: a bare name such as `radarr` also matches `api.radarr.video`, bypassing the proxy before v2rayA can apply its rules.

For other components, use their outgoing HTTP proxy setting with the same endpoint and configure local traffic to bypass the proxy.

The proxy must be reachable from each container. When using `host.docker.internal` on Linux, add this under the relevant service in its Compose file, then recreate the container:

```yaml
extra_hosts:
  - "host.docker.internal:host-gateway"
```

## FlareSolverr outgoing proxy

FlareSolverr uses `PROXY_URL` in [its Compose configuration](compose.yml) for outgoing browser requests. For Prowlarr's FlareSolverr integration, see the [indexer proxy settings](../prowlarr/README.md#flaresolverr-indexer-proxy).

## v2rayA routing rules

If v2rayA provides the host proxy, select RoutingA as the routing mode and add these rules before any matching direct rule:

```text
# Media services and indexers
domain(domain: servarr.com) -> proxy
domain(domain: prowlarr.com) -> proxy
domain(domain: radarr.video) -> proxy
domain(domain: sonarr.tv) -> proxy
domain(domain: nyaa.si) -> proxy
domain(domain: 1337x.to) -> proxy
domain(domain: eztvx.to) -> proxy
domain(domain: limetorrents.fun) -> proxy
domain(domain: thepiratebay.org, domain: apibay.org) -> proxy
```

Save and apply the rules. Use v2rayA's HTTP rule port (`20172` by default) as the shared proxy port so these rules apply. Choose a proxy exit that can access the required services.

If an indexer uses another mirror, add that mirror's domain to the rules too.
