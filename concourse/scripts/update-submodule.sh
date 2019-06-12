#!/usr/bin/env sh
git clone --recurse-submodules speedtest_exporter speedtest_exporter_updated
cd speedtest_exporter_updated/src
export SUBMODULE_PREV_REF=$(git rev-parse HEAD)
git reset --hard origin/master
export SUBMODULE_REF=$(git rev-parse HEAD)
cd ..
git diff-index --quiet HEAD -- && echo "No update required" && exit 0
git add src
read -r -d '' COMMIT_MESSAGE <<EOM
[CI] Updated src

From: ${SUBMODULE_PREV_REF}
To: ${SUBMODULE_REF}
[ci-skip]
EOM
git commit -m "${COMMIT_MESSAGE}"
