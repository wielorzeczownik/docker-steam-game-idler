# Contributing

Every contribution helps, including a typo fix, a bug report, or a question about how something works. For anything bigger than a small fix, opening an issue first is a good idea, so we can agree on the approach before you spend time on it.

One thing to know up front: the image unpacks the official Steam Game Idler `.deb` and runs it as it is. Steam Game Idler is under the [Elastic License 2.0](https://github.com/zevnda/steam-game-idler/blob/main/LICENSE), which forbids touching its license key (PRO) functionality, so changes that patch or unlock app features won't be accepted. Bugs in the app itself belong [upstream](https://github.com/zevnda/steam-game-idler/issues).

## Setup

```bash
git clone https://github.com/wielorzeczownik/docker-steam-game-idler.git
cd docker-steam-game-idler
docker build -t steam-game-idler:dev .
docker run --rm -p 5800:5800 -v "$PWD/config:/config" steam-game-idler:dev
```

The app is x86_64 only. On an ARM machine, add `--platform linux/amd64` to both commands.

## Checks

CI runs these on every pull request. You don't have to run them all locally, since CI will point out anything that's off:

```bash
hadolint Dockerfile

shfmt --diff rootfs/ scripts/
shellcheck rootfs/startapp.sh rootfs/etc/cont-init.d/*.sh scripts/*.sh
actionlint
npx prettier --check .
markdownlint-cli2 "**/*.md"
```

CI also builds the image, checks that the web UI and the app start, and scans the image with Trivy.

## Updating Steam Game Idler

Renovate opens a pull request when a new Steam Game Idler release appears. It bumps `SGI_VERSION` in the Dockerfile, and merging it publishes a new image. To do it by hand, change `SGI_VERSION` and commit it as `feat(app): update Steam Game Idler to x.y.z`.

## Commits and pull requests

Commits follow [Conventional Commits](https://www.conventionalcommits.org/) (`feat: ...`, `fix: ...`), because the changelog and version bumps are generated from them. Don't worry if you get the prefix wrong, it can be fixed before merging.

Smaller PRs that do one thing are easier to review. It helps to say how you tested the change and on what host.

Bugs and ideas go to [issues](https://github.com/wielorzeczownik/docker-steam-game-idler/issues). Security problems go through [SECURITY.md](SECURITY.md).

Contributions are licensed under the [MIT License](LICENSE).
