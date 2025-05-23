
# A modern load testing tool, using Go and JavaScript (k6)

**k6** is a modern load-testing tool, built on our years of experience in the performance and testing industries. It's built to be powerful, extensible, and full-featured. The key design goal is to provide **the best developer experience**.

## Example Usage

```json
"features": {
    "ghcr.io/grafana/devcontainer-features/k6:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select the version to install | string | latest |

## Documentation

Visit the [GitHub repository](https://github.com/grafana/k6) for documentation.

### Features

- **Configurable load generation.** Even lower-end machines can simulate lots of traffic.
- **Tests as code.** Reuse scripts, modularize logic, version control, and integrate tests with your CI.
- **A full-featured API.** The scripting API is packed with features that help you simulate real application traffic.
- **An embedded JavaScript engine.** The performance of Go, the scripting familiarity of JavaScript.
- **Multiple Protocol support**. HTTP, WebSockets, gRPC, Browser, and more.
- **Large extension ecosystem.** You can extend k6 to support your needs. And many people have already shared their extensions with the community!
- **Flexible metrics storage and visualization**. Summary statistics or granular metrics, exported to the service of your choice.
- **Native integration with Grafana cloud**. [SaaS solution](https://grafana.com/products/cloud/k6/) for test execution, metrics correlation, data analysis, and more.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/grafana/devcontainer-features/blob/main/src/k6/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
