# dotfiles
<img src="./img/logo.svg" align="right" width="156px">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

* Automated with **Ansible**.
* Packages installed with **Homebrew**.
* Dotfiles managed with **GNU Stow**.
* No third-party **dependencies**.

<br clear="right">

```makefile
Usage: make <tag> (defaults to "all" if empty)

Available tags:
all
brew
stow

Available commands:
  make check_ansible         Check if Ansible is installed.
  make install_ansible       Install Ansible.
  make install_collections   Install required Ansible collections.
  make run_playbook          Run the Ansible playbook.
  make help                  Display this help message.
```

```shell
git clone https://github.com/robertstojs/dotfiles.git
cd dotfiles
make
```
