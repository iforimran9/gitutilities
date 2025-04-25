#!/bin/bash

# GitHub repository and environment details
REPO_OWNER="GITHUB_USERNAME"
REPO_NAME="GITHUB_REPO_NAME"
ENV_NAME="ENVIRONMENT_NAME"


declare -A VARIABLES=(
    ["variable_01"]="Development"
    ["variable_02"]="1000"
    ["variable_03"]="your.email@domain.com"
)

declare -A SECRETS=(
    ["secure_url"]="http\://localhost\:7001/"
    ["interface_password"]="password"
    ["interface_username"]="username"
)

echo "Adding variables to environment '$ENV_NAME'..."
for VAR in "${!VARIABLES[@]}"; do
    echo "Adding variable: $VAR"
    gh api --method POST -H "Accept: application/vnd.github+json" \
      "/repos/$REPO_OWNER/$REPO_NAME/environments/$ENV_NAME/variables" \
      -f name="$VAR" \
      -f value="${VARIABLES[$VAR]}"
done

echo "Adding secrets to environment '$ENV_NAME'..."
for SECRET in "${!SECRETS[@]}"; do
    echo "Adding secret: $SECRET"
    echo "${SECRETS[$SECRET]}" | gh secret set "$SECRET" --repo "$REPO_OWNER/$REPO_NAME" --env "$ENV_NAME"
done
