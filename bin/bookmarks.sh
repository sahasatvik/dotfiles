#!/usr/bin/env sh

# Each line in 'bookmarkfile' is in either of the following formats
# Title                 ;; https://url.abc
# Another title         ;; https://url.xyz      ;; Extra notes/tags

bookmarkfile="$HOME/.config/bookmarks"
declare -A bookmarks
keys=""

strip_excess() {
        sed 's/^\s*#.*$//g' | sed '/^$/d' | sed 's/\s*;;\s*/;;/g'
}

while read line; do
        name="${line%%;;*}"
        urlnotes="${line#*;;}"
        url="${urlnotes%;;*}"
        url="${url//&/&amp;}"
        notes="${urlnotes#*;;}"
        if [[ "$url" == "$notes" ]]; then
                key="$name"
        else
                if [[ ${#name} -gt 75 ]]; then
                        name="${name:0:72}..."
                fi
                key=$(printf "%-75s  <small><span color=\"#777777\">%s</span></small>\n" "$name" "$notes")
        fi
        bookmarks[$key]="$url"
        keys="${keys}\n${key}"
done < <(cat "$bookmarkfile" | strip_excess)
keys="${keys#\\n}"

get_url() {
        key=$(echo -e "$keys" | rofi -dmenu -markup-rows -i -p 'bookmarks')
        if [[ -z "$key" ]]; then
                echo -e ""
        else
                echo ${bookmarks[${key}]}
        fi
}

url="$(get_url)"
[[ -z "$url" ]] && exit 1;
echo $url
qutebrowser "$url" &> /dev/null
