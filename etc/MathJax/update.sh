#!/usr/bin/env bash
# Update the packaged MathJax
#
# Usage:
#  etc/MathJax/update.sh [-c]
#
# By default only new files are added to the target directory.
# Use the argument `-c` to perform cleanup first.

MathJax_VERSION="2.7.4"
MathJax_CONFIG="TeX-MML-AM_HTMLorMML"

MathJax_REPOSITORY="https://github.com/mathjax/MathJax"

# paths are relative to the MathJax code repository
MathJax_FILES_IN=`cat <<FILES
MathJax.js
config/${MathJax_CONFIG}.js
extensions/tex2jax.js
extensions/mml2jax.js
extensions/asciimath2jax.js
extensions/TeX/AMSmath.js
extensions/TeX/AMSsymbols.js
extensions/TeX/noErrors.js
extensions/TeX/noUndefined.js
fonts/HTML-CSS/TeX/eot
fonts/HTML-CSS/TeX/otf
fonts/HTML-CSS/TeX/woff
jax/input/TeX
jax/input/MathML
jax/input/AsciiMath
jax/output/HTML-CSS/jax.js
jax/output/HTML-CSS/fonts/TeX
FILES`

# stop at the first non zero exit, include errors in pipes
set -o errexit -o pipefail


cd `dirname $0`/../../

MathJax_TAR_GZ_URL="$MathJax_REPOSITORY/archive/$MathJax_VERSION.tar.gz"

MathJax_TARGET="src/main/webapp/js/MathJax"
MathJax_CACHE=".cache/MathJax/$MathJax_VERSION"

if [[ $1 == "-c" ]]; then
    echo "-- target $MathJax_TARGET cleaned --"
    rm -rf "$MathJax_TARGET"
fi

if [[ ! -d "$MathJax_CACHE" ]]; then
    echo "-- cache miss for MathJax version $MathJax_VERSION --"
    echo "-- downloading MathJax version $MathJax_VERSION --"
    mkdir --parents "$MathJax_CACHE"
    curl --location "$MathJax_TAR_GZ_URL" \
    | tar --extract --gzip --strip-components=1 --directory="$MathJax_CACHE"
fi

for file in ${MathJax_FILES_IN}; do
    target_path=`dirname "$MathJax_TARGET/$file"`
    mkdir -p "$target_path"
    cp --update --recursive "$MathJax_CACHE/$file" "$target_path"
done

echo "-- MathJax updated --"
du --human-readable --max-depth 1 "$MathJax_TARGET"
