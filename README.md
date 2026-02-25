# dtcli - Dependency Track CLI

A command-line interface for interacting with Dependency Track's REST API.
Including completion for bash and zsh.

## Installation

1. Make the script executable:
   ```shell
   chmod +x dtcli
   ```

2. Move it to a directory in your PATH:
   ```shell
   sudo cp dtcli /usr/local/bin/
   ```
    or
    ```shell
    cp dtcli ~/.local/bin/
    ```
    
3. Set up environment variables:
   ```bash
   export DTCLI_URL="https://your-dependency-track-instance.com"
   export DTCLI_API_KEY="your-api-key-here"
   ```

## Shell Completion

### Bash

#### Copy completion file
```shell
sudo cp dtcli-completion.bash /etc/bash_completion.d/dtcli
```

Or for user-only installation
```shell
mkdir -p ~/.local/share/bash-completion/completions 
cp dtcli-completion.bash ~/.local/share/bash-completion/completions/dtcli
```

### Zsh

Copy to zsh completions directory

```shell
sudo mkdir -p /usr/local/share/zsh/site-functions/
sudo cp _dtcli /usr/local/share/zsh/site-functions/
```
Or for user-only installation
```shell
mkdir -p ~/.zsh/completion cp _dtcli ~/.zsh/completion/
```

## Usage

### Upload SBOM
```shell
dtcli upload --project grafana --version 12.1.1 --parent-project home-lab --latest sbom.json
```

### Check for Updates
```shell
dtcli has-update --project grafana
``` 

### Check Policy Violations
```shell
dtcli has-policy-violations --project grafana
```

## Dependencies

- `curl` - for API requests
- `jq` - for JSON parsing
- `base64` - for encoding SBOM files

## Configuration

Set these environment variables:

- `DTCLI_URL` - Dependency Track instance URL (default: http://localhost:8080)
- `DTCLI_API_KEY` - Your API key (required)

