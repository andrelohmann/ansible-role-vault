#!/usr/bin/env bash

# Pfad zur Vault CLI
VAULT_BIN=$(which vault)

# Falls du environment variables für Vault brauchst
export VAULT_ADDR="https://127.0.0.1:8200"
# Ggf. export VAULT_TOKEN=... (wenn du später root_token brauchst)
export VAULT_SKIP_VERIFY="true"

# Deine Unseal-Keys. ACHTUNG: Sicherheitsrisiko, wenn du sie im Klartext hier speicherst!
UNSEAL_KEY_1=$(cat /opt/vault/tokens/tokens.json | jq -r .unseal_keys_b64[0])

# Prüfung, ob Vault bereits unsealed ist:
SEALED=$($VAULT_BIN status -format=json | jq -r .sealed)
if [ "$SEALED" == "false" ]; then
  echo "Vault is already unsealed."
  exit 0
fi

# Andernfalls unseal:
$VAULT_BIN operator unseal "$UNSEAL_KEY_1"

# Prüfen:
SEALED=$($VAULT_BIN status -format=json | jq -r .sealed)
if [ "$SEALED" == "false" ]; then
  echo "Vault successfully unsealed."
else
  echo "Vault is still sealed! Check logs or keys."
fi

exit 0