# Static Tmux Builder

A Docker-based builder for building static [tmux](https://github.com/tmux/tmux)!

## Prerequisites

- [Docker](https://www.docker.com/)

## Usage

```bash
docker build -t static-tmux-builder .
docker run --rm -v $(pwd):/build -w /build static-tmux-builder ./build.sh
```

The built tmux binary will be available in the current directory.
