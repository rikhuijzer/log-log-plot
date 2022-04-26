#!/usr/bin/env bash

set -e

gnuplot \
    -e "XTICKS=(4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)" \
    log-log.p
