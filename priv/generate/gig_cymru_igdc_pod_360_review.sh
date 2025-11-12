#!/bin/sh
set -euf

export App=Dryw
export app=dryw
export Dom=GigCymruIgdcPod360
export dom=gig_cymru_igdc_pod_360
export Resource=Review
export resource=appraisal
export Resources=Review
export resources=appraisals

mix ash.gen.resource \
    $App.$Dom.$Resource \
    --conflicts replace \
    --default-actions create,read,update,destroy \
    --extend postgres \
    --uuid-primary-key id \
    --relationship belongs_to:reviewer:$App.Accounts.User \
    --relationship belongs_to:reviewee:$App.Accounts.User \
    --attribute collaboration:integer \
    --attribute innovation:integer \
    --attribute inclusive:integer \
    --attribute excellence:integer \
    --attribute compassion:integer \

mix ash.codegen create_$resources
mix ash.migrate

mkdir -p test/$app/$dom
touch test/$app/$dom/$resource.ex

mkdir -p lib/${app}_web/$dom/$resources
touch lib/${app}_web/$dom/$resources/form_live.ex
touch lib/${app}_web/$dom/$resources/index_live.ex
touch lib/${app}_web/$dom/$resources/show_live.ex

mkdir -p test/${app}_web/$dom/$resources
touch test/${app}_web/$dom/$resources/form_test.ex
touch test/${app}_web/$dom/$resources/index_test.exs
touch test/${app}_web/$dom/$resources/show_test.exs

cat << EOF
Edit file lib/${app}_web/router.ex to add live routes:
live "/$resources", $Resources.IndexLive
live "/$resources/:id", $Resources.ShowLive
live "/$resources/:id/edit", $Resources.FormLive, :edit
EOF
