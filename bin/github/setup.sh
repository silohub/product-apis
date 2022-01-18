#!/usr/bin/env bash
set -e # exit on first failed command
set -x # mostrar cada comando que se ejecuta
# este script inicializa el entorno de codemagic antes de empezar a ejecutar
#
# depende de estas variables de entorno
# $FCI_BRANCH - el branch donde está corriendo
# $BUILD_NUMBER - el numero de build
# $FCI_BUILD_DIR - el directorio donde estamos compilando
# GCP_CREDENTIALS_$FCI_BRANCH - auth de Google Cloud
# $APP_CODE - el nombre de la app que vamos a compilar
#
# shellcheck disable=SC2128
# esto carga las variables de entorno y verifica las versiones
. "$(dirname "${BASH_SOURCE}")/../.load-env.sh"
#
# creamos el directorio build
SH_TMP_DIR="${FCI_BUILD_DIR:?la variable de entorno FCI_BUILD_DIR no está}/build/tmp"
mkdir -p "$SH_TMP_DIR"
#
# branch en mayuscula
FCI_BRANCH_UPPER=$(echo "${FCI_BRANCH:?la variable de entorno FCI_BRANCH no está}"| tr '[:lower:]' '[:upper:]')
#
# GCP login
printenv -- "GCP_CREDENTIALS_$FCI_BRANCH_UPPER" | base64 --decode > "$SH_TMP_DIR/gcloud_auth.json"
gcloud auth activate-service-account --key-file "$SH_TMP_DIR/gcloud_auth.json"
#
# setup Android keystore
# por ahora cableamos la password aca y en gradle porque se genera aca en vivo
KEY=androidreleasekey
KEY_PASS=SILOHUB
STORE_PASS=SILOHUB
printenv -- "ANDROID_SIGN_CRT_$FCI_BRANCH_UPPER" | base64 --decode > "$SH_TMP_DIR/android_sign.crt"
printenv -- "ANDROID_SIGN_KEY_$FCI_BRANCH_UPPER" | base64 --decode > "$SH_TMP_DIR/android_sign.key"
echo "Converting CRT to P12"
openssl pkcs12 -export -in "$SH_TMP_DIR/android_sign.crt" -inkey "$SH_TMP_DIR/android_sign.key" -out "$SH_TMP_DIR/android_sign.p12" -name $KEY -password pass:$KEY_PASS
echo "Creating Keystore"
keytool -importkeystore -srcstoretype PKCS12 -srckeystore "$SH_TMP_DIR/android_sign.p12" -srcstorepass $KEY_PASS -destkeystore "$SH_TMP_DIR/android_sign.keystore" -storepass $STORE_PASS
#
# pnpm install
corepack enable
corepack prepare pnpm@"$PNPM_VERSION" --activate
APP_DIR="$BASE_DIR/apps/${APP_CODE:?la variable de entorno APP_CODE no está}"
pnpm --dir "$APP_DIR" install --frozen-lockfile --prefer-frozen-lockfile
