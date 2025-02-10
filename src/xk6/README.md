
# Build k6 with extensions (xk6)

This command line tool and associated Go package makes it easy to make custom builds of [k6](https://github.com/grafana/k6). It is used heavily by k6 extension developers as well as anyone who wishes to make custom `k6` binaries (with or without extensions).

## Example Usage

```json
"features": {
    "ghcr.io/grafana=devcontainer-features/xk6:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select the version to install | string | latest |

## Documentation

Visit the [GitHub repository](https://github.com/grafana/xk6) for documentation.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
