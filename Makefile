.PHONY: check_ansible install_ansible install_collections run_playbook notify complete help

default: check_ansible install_collections run_playbook notify complete

check_ansible:
	@command -v ansible >/dev/null 2>&1 || { echo "Ansible is not installed."; read -p "Do you want to install Ansible? [y/N] " -n 1 -r; echo; if [[ $$REPLY =~ ^[Yy]$$ ]]; then $(MAKE) install_ansible; else echo "Ansible installation aborted. Exiting."; exit 1; fi; }

install_ansible:
	@echo "Installing Ansible..."
	@sudo pip3 install --upgrade pip
	@pip3 install ansible
	@echo "Ansible installed successfully."

install_collections:
	@echo "Installing collections from requirements.yml..."
	@ANSIBLE_CONFIG=$$(pwd)/ansible.cfg ansible-galaxy install -r $$(pwd)/requirements.yml >/dev/null 2>&1
	@echo "Collections installed successfully."

run_playbook:
	@TAGS=""; \
	VALID_TAGS="all $$(awk '/tags:/{print $$2}' playbook.yml | tr -d '[]' | sort | uniq)"; \
	if [ -z "$(ARGS)" ] || [ "$(ARGS)" = "default" ]; then \
		TAGS="all"; \
		TAGS_ARG="--tags all"; \
	else \
		TAGS="$(ARGS)"; \
		TAGS_ARG=""; \
		for arg in $(ARGS); do \
			if echo "$$VALID_TAGS" | grep -q -w "$$arg"; then \
				TAGS_ARG="$$TAGS_ARG --tags $$arg"; \
			else \
				echo "Error: Invalid tag '$$arg'"; \
				exit 1; \
			fi; \
		done; \
	fi; \
	echo "Running Ansible playbook with tags: $$TAGS"; \
	ANSIBLE_CONFIG=$$(pwd)/ansible.cfg ansible-playbook $$(pwd)/playbook.yml --ask-become-pass $$TAGS_ARG; \
	if [ -n "$(ARGS)" ] && [ "$(ARGS)" != "default" ]; then \
		exit 0; \
	fi

notify:
	@command -v terminal-notifier >/dev/null 2>&1 && terminal-notifier -title "dotfiles: Setup complete" -message "Successfully set up environment."

complete:
	@echo "Setup process completed successfully."

help:
	@echo "Usage: make <tag> (defaults to "\"all"\")"
	@echo ""
	@echo "Available tags:"
	@echo "all"
	@awk '/tags:/{print $$2}' playbook.yml | tr -d '[]' | sort | uniq
	@echo ""
	@echo "Available commands:"
	@echo "  make check_ansible         Check if Ansible is installed."
	@echo "  make install_ansible       Install Ansible."
	@echo "  make install_collections   Install required Ansible collections."
	@echo "  make run_playbook          Run the Ansible playbook."
	@echo "  make help                  Display this help message."

# Override the default target to pass arguments to run_playbook
%:
	@$(MAKE) ARGS="$@" run_playbook
