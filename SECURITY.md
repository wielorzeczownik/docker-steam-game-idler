# Security

Thanks for taking the time to look. Please report vulnerabilities privately through [GitHub Security Advisories](https://github.com/wielorzeczownik/docker-steam-game-idler/security/advisories/new) instead of a public issue, so there's a chance to fix them first. You'll be credited in the release notes unless you'd rather not be. Only the latest release gets fixes.

## In scope

The container holds a signed-in Steam session, so the scope is:

- the web viewer on port 5800 and the VNC port 5900, and how they are protected
- the Steam session, keyring and machine ID stored in `/config`
- how the image fetches and unpacks the Steam Game Idler release

Problems in Steam Game Idler itself go to [its maintainer](https://github.com/zevnda/steam-game-idler/security). Problems in the web viewer or VNC server go to [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui).

## Running it safely

- Don't expose port 5800 or 5900 to the internet. Use a VPN or a reverse proxy with authentication.
- Set `WEB_AUTHENTICATION=1` with a username and password if others can reach the host.
- Treat `/config` like a password. It holds the Steam session.
- Keep the image up to date.
