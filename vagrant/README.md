# Test your role with vagrant

Test your role with vagrant

## Prerequisites

* Virtualbox is installed
* Vagrant is installed
* vagrant up will install vagrant-hostmanager module

## Test process

```
cd vagrant
vagrant up
```

The vagrant role will be applied automatically during the vagrant up process.

### Test with molecule from inside vagrant

```
vagrant ssh
cd /etc/ansible/roles/ansible-role-vault
molecule test
```

### Test cases

You can run simple vault commands from the command line to check the functionality of vault.

```
export VAULT_ADDR="https://127.0.0.1:8200"
export VAULT_TOKEN=$(cat /opt/vault/tokens/tokens.json | jq -r .root_token)
export VAULT_SKIP_VERIFY="true"

vault status
```
