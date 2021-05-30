#!/bin/sh

ansible-playbook --diff --inventory "$1", --user ubuntu --become ansible/minecraft.yml --extra-vars edition=bedrock