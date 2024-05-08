# Sample Project: Playing with systemd-sysext

This is a sample project that allows me to experiment with systemd-sysext, a tool for extending the /usr/ and /opt/ directory trees at runtime.

## Prerequisites

- Modern Linux system (with a recent systemd installed)
- Make
- sudo access

> [!WARNING]
> When using systemd-sysext to mount system extensions, please ensure that you carefully check the permissions of the extensions being mounted. It is crucial to verify that these permissions are configured correctly (e.g. umask usage), as incorrect settings can lead to the extension's permissions "masking" those of system directories. This masking effect may restrict access to executable files, requiring a system restart to resolve.

## Instructions

Use the Makefile rules.

### Build Rules

- **`build-v1` and `build-v2`**: These rules trigger the building of extensions for versions v1 and v2 respectively.

### Installation Rules

- **`install-v1`**: Install the v1 image into a systemd extension directory (e.g. /var/lib/extensions).

> [!NOTE]
> Later (TODO), the v2 image will be deployed using `systemd-sysupdate` through an HTTP server (hence the `serve` target).


### System Extensions Management

- **`merge` and `unmerge`**: These commands use systemd-sysext to merge or separate the system extensions.
- **`debug`**: Displays the currently merged system extensions and their status.

### Cleaning

- **`clean`**: Removes all files in the output directory.
- **`distclean`**: Executes clean and also removes files in the extension directory with confirmation.

## Tips

Here are some useful commands to interact with your built extensions:

- Use unsquashfs to list the contents of the squashfs file:
```bash
unsquashfs -ll <extension>
```

- Use systemd-dissect to inspect the contents of the OS image:
```bash
sudo systemd-dissect <extension>
```

- Prepend systemd commands with `SYSTEMD_LOG_LEVEL=debug` to enhance debugging outputs.
