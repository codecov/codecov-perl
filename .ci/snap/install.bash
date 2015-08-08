#!/bin/bash

set -e

bash .ci/install-perl.bash
bash .ci/install-cpanm.bash
bash .ci/install-carton.bash
bash .ci/carton-install.bash
