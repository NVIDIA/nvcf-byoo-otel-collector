# nvcf-byoo-otel-collector

[![CI](https://github.com/NVIDIA/nvcf-byoo-otel-collector/actions/workflows/ci.yml/badge.svg)](https://github.com/NVIDIA/nvcf-byoo-otel-collector/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)

Bring Your Own Observability (BYOO) OpenTelemetry Collector for [NVIDIA Cloud Functions (NVCF)](https://docs.nvidia.com/cloud-functions/).

## Overview

`nvcf-byoo-otel-collector` is an OpenTelemetry Collector distribution for NVCF
functions that enables custom observability pipelines. It allows NVCF function
operators to collect metrics, logs, and traces and forward them to their own
observability backends.

## Requirements

- Go 1.23 or later
- Docker (for building the collector image)

## Building

```bash
make build
```

## Development

### Build

```bash
go build ./...
```

### Test

```bash
go test ./...
```

### Lint

```bash
go vet ./...
golangci-lint run ./...
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

All pull requests must be signed off with the Developer Certificate of Origin
(DCO). See [CONTRIBUTING.md](CONTRIBUTING.md) for instructions.

## License

Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.

Licensed under the [Apache License, Version 2.0](LICENSE).

## Security

Please report security vulnerabilities via [SECURITY.md](SECURITY.md).
