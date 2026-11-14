#!/usr/bin/env bash

# Stop on command failures or use of unset variables.
set -eu

# Work from the script's parent directory (project root); -- ends options, and quotes preserve spaces.
cd -- "$(dirname -- "$0")/.."

for media_dir in \
  jellyfin/config jellyfin/config/data jellyfin/config/log jellyfin/config/cache \
  prowlarr/config \
  qbittorrent/config qbittorrent/data \
  radarr/config radarr/data radarr/data/downloads radarr/data/movies \
  seerr/config \
  sonarr/config sonarr/data sonarr/data/downloads sonarr/data/shows; do
  mkdir -p "$media_dir"
  sudo chown -R 1000:1000 "$media_dir"
done
