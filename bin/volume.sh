#!/usr/bin/env sh

amixer sget Master | grep 'Mono:' | grep -oe '[0-9]*%'
