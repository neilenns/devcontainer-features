
# oh-my-zsh (oh-my-zsh)

Installs zsh and OhMyZsh, sets zsh as the default shell for the remote user, and configures OhMyZsh based on the feature settings.

## Example Usage

```json
"features": {
    "ghcr.io/neilenns/devcontainer-features/oh-my-zsh:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| plugins | A space separated list of plugins to activate. | string | git |
| desiredLocale | The locale that should be set when `setLocale` is true. | string | en_US.UTF-8 UTF-8 |
| disableAutoUpdate | Disable automatic updates of OhMyZsh. | boolean | true |
| disableUpdatePrompt | Disable the update prompt of OhMyZsh. | boolean | true |
| setDefaultUserToRemoteUser | Set the theme's `DEFAULT_USER` to the container's `remoteUser`. | boolean | true |
| setLocale | Install required locales package and set locale. | boolean | true |
| stripWorkspacesFromPrompt | Strips `/workspaces/` from the front of the command prompt. | boolean | false |
| theme | The theme to activate in .zshrc. | string | agnoster |

## OS Support

This feature currently only supports Debian based containers (where APT is used as package manager).

`bash` is required to run the install script.

## Acknowledgements

This feature is based on the [zsh feature by Nils Geistmann](https://github.com/nils-geistmann/devcontainers-features/tree/main/src/zsh).


---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/neilenns/devcontainer-features/blob/main/src/oh-my-zsh/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
