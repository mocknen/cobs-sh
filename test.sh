#!/usr/bin/zsh

. ${ZSH_ARGZERO:h:a}/cobs.sh
. ${ZSH_ARGZERO:h:a}/test-io.sh

typeset -A err=([encode]=0 [decode]=0)

function cobs_test {
    emulate -L zsh
    setopt pipe_fail
    setopt NO_multibyte
    setopt NO_unset
    readonly op=${1}
    local input output tmp input_bin output_bin ret_bin i
    integer cnt=0
    for input output in ${(@kv)test_io}; do
        ((++cnt % 10)) || printf '.'
        case $op in
            encode) ;;
            decode)
                tmp=$input
                input=$output
                output=$tmp
                ;;
            *)
                false
        esac
        printf '%b' $input | read -ru0 -k$(($#input / 4)) input_bin
        printf '%b' $output | read -ru0 -k$(($#output / 4)) output_bin
        ret_bin=
        cobs_$op $input_bin | () {
            local buf
            while read -ru0 -t1 -k1 buf; do
                ret_bin+=$buf
            done
        }
        if [[ $ret_bin != $output_bin ]]; then
            ((++err[$op]))
            print "${(C)op} Error"
            printf 'Input: %s\n' ${input//\\x/ }
            printf 'Expect:%s\n' ${output//\\x/ }
            printf 'Result:'
            for ((i = 1; i <= $#ret_bin; i++)); do
                printf ' %02x' $(cobs_bin_to_int $ret_bin[i])
            done
            print
            print
        fi
    done
    printf '\n%s test ' ${(C)op}
    if ((err[$op])); then
        print 'failed.'
    else
        print 'passed.'
    fi
    print
}

cobs_test encode
cobs_test decode

exit $((err[encode] || err[decode]))
