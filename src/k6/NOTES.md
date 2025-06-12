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
