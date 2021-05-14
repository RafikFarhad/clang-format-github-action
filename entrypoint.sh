#!/bin/bash -
#title          :entrypoint.sh
#description    :This script runs clang format on slected file/folder and exit with status 0 if every file is formated correctly.
#author         :RafikFarhad<rafikfarhad@gmail.com>
#date           :20200809
#version        :1.0.0
#usage          :./entrypoint.sh
#notes          :Optional env values are: INPUT_STYLE,INPUT_SOURCES
#bash_version   :5.0.17(1)-release
###################################################
function log() {
    echo -e "[ gh-action ] :: $1"
}
function split_csv() {
    IFS=','
    csv_data="$1"
    local -n global_list_array="$2"
    for i in $csv_data; do
        if [ -f "$i" ]; then
            global_list_array+=("$i")
        fi
    done
    unset IFS
}

SOURCES=()
PROBLEMETIC_FILES=()
EXIT_STATUS=0
STYLE="-style=file"

function resolve_inputs() {
    INPUT_STYLE=${INPUT_STYLE:-"file"}
    if [[ $INPUT_STYLE != "file" ]]; then
        STYLE="--style=$INPUT_STYLE"
    fi
    INPUT_SOURCES=${INPUT_SOURCES:-"**/*"}
}

function check_file() {
    local file="$1"
    message="$(clang-format -n -Werror --ferror-limit=1 $STYLE --fallback-style=LLVM "${file}")"
    local status="$?"
    if [ $status -ne 0 ]; then
        echo "$message" >&2
        EXIT_STATUS=1
        return 1
    fi
    return 0
}

function main() {
    log "Action started"
    resolve_inputs
    log "Sources to check: $INPUT_SOURCES\n"
    split_csv "$INPUT_SOURCES" SOURCES

    for file in "${SOURCES[@]}"; do
        check_file "$file"
        if [ $? -ne 0 ]; then
            PROBLEMETIC_FILES+=("$file")
        fi
    done

    if [ $EXIT_STATUS -eq 0 ]; then
        log "Congrats! The sources are clang formatted."
        exit 0
    else
        log "Some file is not formatted correctly."
        log "You might want to run: "
        for ((i = 0; i < ${#PROBLEMETIC_FILES[@]}; i++)); do
            if [ $i -ne 0 ]; then
                echo -n " && "
            fi
            echo "clang-format -style=file -i "${PROBLEMETIC_FILES[$i]}" \\"
        done
        exit 1
    fi
}

cd "$GITHUB_WORKSPACE" || exit 2
main
