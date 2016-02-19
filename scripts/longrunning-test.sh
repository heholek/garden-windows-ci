#!/usr/bin/env bash

set -ex

appname=`mktemp noraXXXXX`
domain=greenhouse-development2.cf-app.com
url=$appname.$domain

# Assumes diego-windows-msi under ./diego-windows-msi
export nora_dir=$PWD/wats
function cf {
    ${nora_dir}/bin/cf-linux "$@"
}

export -f cf

cf api --skip-ssl-validation api.$domain
cf login -u $CF_USERNAME -p $CF_PASSWORD -o ORG -s SPACE
cf delete-orphaned-routes -f

pushd ${nora_dir}/assets/nora
  ./make_a_nora $appname
popd

cf scale -f -i 3 $appname

for i in {1..300}; do
    count=`cf app $appname | grep running | wc -l`
    if [ $count -eq 3 ]; then
        break;
    fi
    sleep 1
done

if [ $count -ne 3 ]; then
    echo "scaling failed"
    exit 1
fi

# TODO: make sure we hit all three instances
for i in {1..10}; do
    curl $url
done

cf d $appname -r -f
greenhouse-ci/scripts/run-monitor-health.rb
