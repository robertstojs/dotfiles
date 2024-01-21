# dotfiles
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

* Automated with **Ansible**.
* Packages installed with **Homebrew**.
* Dotfiles managed with **GNU Stow**.

```shell
git clone https://github.com/robertstojs/dotfiles.git
cd dotfiles
bash bootstrap all
# or when only running a specific tag (defaults to 'stow')
bash bootstrap <tag>
```