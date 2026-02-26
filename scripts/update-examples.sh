#!/usr/bin/env bash
# SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
# SPDX-License-Identifier: Apache-2.0


set -euo pipefail

export ESS_SECRETS_PATH="$(pwd)/examples/secrets"

local_secrets_path="$(pwd)/examples/secrets"
real_secrets_path="/etc/byoo-otel-collector/secrets"

mkdir -p _output
for input_file in testdata/*.json; do
    echo "=== Test $input_file ==="
    basename=$(basename "${input_file}" .json)
    for backend_type in vm k8s; do
        for compute_type in task function; do
            for req_type in container helm; do
                echo "Generating configs backend_type=${backend_type} request_type=${req_type} compute_type=${compute_type}..."
                go run scripts/generate-otelconfig.go $input_file _output/otelconfigs ${backend_type} ${req_type} ${compute_type}
                generated_file=$(ls _output/otelconfigs/config.${compute_type}_${backend_type}_${req_type}.yaml)
                cp $generated_file examples/otelconfigs/${backend_type}/config_${compute_type}_${req_type}_${basename}.yaml
                if [[ "$(uname -s)" == "Darwin" ]]; then
                    sed -i "" "s|${local_secrets_path}|${real_secrets_path}|g" examples/otelconfigs/${backend_type}/config_${compute_type}_${req_type}_${basename}.yaml
                else
                    sed -i "s|${local_secrets_path}|${real_secrets_path}|g" examples/otelconfigs/${backend_type}/config_${compute_type}_${req_type}_${basename}.yaml
                fi
                rm $generated_file
            done
        done
    done
done
