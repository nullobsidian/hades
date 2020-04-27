#!/bin/bash

set -e

# Variables

REQS=(
	dnf-plugins-core
)

KEYS=(
	'https://download.sublimetext.com/sublimehq-rpm-pub.gpg'
	'https://brave-browser-rpm-release.s3.brave.com/brave-core.asc'
	
)

REPOS=(
	'https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo'
	'https://brave-browser-rpm-release.s3.brave.com/x86_64/'
)

FLATREPOS=(
	'flathub https://flathub.org/repo/flathub.flatpakrepo'
)

USER_CMD=(
	zsh
	htop
	vim
	tree
	neofetch
	lm_sensors	
)

USER_GUI=(
	sublime
	brave-browser
)

FLATPAK=(
	com.spotify.Client
	com.github.alainm23.planner
)

# Functions

repos () {
	for i in ${KEYS[@]}; do
		rpm -v --import $i
	done
	for i in ${REPOS[@]}; do
		dnf config-manager --add-repo $i 
	done
	for i in ${FLATREPOS[@]}; do
		flatpak remote-add --if-not-exists $i
	done
}

pkgs () {
	dnf install ${USER_CMD[@]} -y
	dnf install ${USER_GUI[@]} -y
	flatpak install flathub ${FLATPAK[@]}
}

# Dependencies

dnf install ${REQS[@]} -y 

# Development Tools

dnf groupinstall "Development Tools" -y

# Repositories

repos
 
# Packages

pkgs

