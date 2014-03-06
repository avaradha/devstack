#!/usr/bin/env bash
echo "Vagrant initiating and will download the box file precise64.."
vagrant init devstack_precise64 http://files.vagrantup.com/precise64.box
echo "Vagrant initiation complete. Continue with Vagrant Up..."
