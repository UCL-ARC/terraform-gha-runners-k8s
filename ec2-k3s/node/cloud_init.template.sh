#!/bin/bash
# shellcheck disable=SC2154

dnf upgrade -y

# cloud-setup needs to be disabled for k3s
# See: https://slack-archive.rancher.com/t/10093428/would-you-expect-k3s-to-install-amp-run-on-an-aws-ec2-rhel9-
systemctl disable nm-cloud-setup.service nm-cloud-setup.timer

k3s_token=$(echo "${k3s_token}" | tr -d '\n')
curl https://get.k3s.io | \
  INSTALL_K3S_EXEC="agent" \
  INSTALL_K3S_VERSION="${k3s_version}" \
  K3S_URL="${k3s_server_url}" \
  K3S_TOKEN="$k3s_token" \
  sh -
