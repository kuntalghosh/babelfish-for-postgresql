#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
OUTDIR=/tmp/build
ENG_URL="https://github.com/babelfish-for-postgresql/postgresql_modified_for_babelfish.git"
EXT_URL="https://github.com/babelfish-for-postgresql/babelfish_extensions.git"

function help(){
  echo "
    Export the following environment variables: TAG, EXTTAG
    Then, execute: ./build.sh
  "
  exit 0
}

if [ ! -v TAG ]
then
    printf "TAG is a mandatory environment variable.\n"
    exit 2
fi

if [ ! -v EXTTAG ]
then
    printf "EXTTAG is a  environment variable.\n"
    exit 2
fi

VERSION=$(echo $TAG | sed -r -e 's/BABEL_([0-9a-z_]*)__PG.*/\1/' -e 's/_/./g')
ENGINE=$(echo $TAG | sed -r -e 's/BABEL_([0-9_]*)__PG_([0-9]+_)/\2/' -e 's/_/./g')

function helper() {
  sed -r -e 's/\{\{VERSION\}\}/'''$VERSION'''/'  $1
  sed -r -e 's/\{\{ENGINE\}\}/'''$ENGINE'''/'  $1
}

rm -rf ${OUTDIR}
mkdir -p $OUTDIR 2> /dev/null


cd ${OUTDIR}

git clone --single-branch -b ${TAG}     ${ENG_URL} ${TAG}
git clone --single-branch -b ${EXTTAG}  ${EXT_URL} ${TAG}-babelfish-extensions

cp -r ${TAG}-babelfish-extensions/test ${TAG}/contrib 
cp -r ${TAG}-babelfish-extensions/contrib/babelfishpg_* ${TAG}/contrib 

cd ${TAG}
rm -rf .git/

helper ${TAG}/INSTALLING.md.tmpl > INSTALLING.md
rm -f ${TAG}/INSTALLING.md.tmpl

cd ${OUTDIR}

zip -qr ${TAG}.zip ${TAG}/
tar cfz ${TAG}.tar.gz ${TAG}/

echo "Output files in: "
ls $OUTDIR/*.{zip,tar.gz}
