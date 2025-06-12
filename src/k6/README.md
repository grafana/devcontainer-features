
# k6 (k6)

This feature installs the k6 CLI tool, which can be used to run load tests defined in JavaScript files.

## Example Usage

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | The k6 version to install. | string | latest |
| with | Comma separated list of extensions to include in the custom k6 build. | string | - |
| xk6-version | The xk6 version to use for a custom k6 build. | string | latest |
| go-version | Go version to use for custom k6 builds. Only used if 'with' is set. | string | latest |

## More Example Usages

### Latest version of the official k6 release

You can easily use this feature by using the latest official k6 release; no special options are needed.

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {}
}
```

### Specific version of the official k6 release

You can install a specific official k6 release by setting the `version` option to your desired version.

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {
        "version": "1.0.0"
    }
}
```

### Custom k6 build with extensions

If you're looking to use **k6 extensions**, you'll need a **custom k6 build**. This feature fully supports installing those custom builds.

To specify which extensions you want, use the `with` option. You can list your desired k6 extensions either as a **comma-separated string** or as an **array of strings**.

**Use latest released versions**

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {
        "with": [
            "github.com/grafana/xk6-example",
            "github.com/grafana/xk6-output-example"
        ]
    }
}
```

**Use specific version tags**

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {
        "with": [
            "github.com/grafana/xk6-example@v1.0.0",
        ]
    }
}
```

**Use specific k6 version with specific extension version**

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {
        "version": "1.0.0",
        "with": [
            "github.com/grafana/xk6-example@v1.0.0"
        ]
    }
}
```

## Documentation

Visit the [k6 GitHub repository](https://github.com/grafana/k6) for k6 documentation.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/grafana/devcontainer-features/blob/main/src/k6/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
