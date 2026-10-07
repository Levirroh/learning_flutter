#!/usr/bin/env bash
set -e
# Gera a pasta Android usando o Flutter instalado na maquina do estudante.
flutter create --platforms=android .
flutter pub get
