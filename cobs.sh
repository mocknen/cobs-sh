#!/usr/bin/zsh

function cobs_encode {
    emulate -L zsh
    setopt err_return
    setopt pipe_fail
    setopt NO_multibyte
    setopt NO_unset

    readonly input=$1
    integer i
    local buffer output nonzero=1

    for ((i = 1; i <= $#input; nonzero++)); do
        if ((nonzero == 255)); then
        elif [[ $input[i] == $'\x00' ]]; then
            ((i++))
        else
            buffer+=$input[i++]
            continue
        fi
        printf '%b' $(printf '\\x%02x' nonzero) | read -ru0 -k1 nonzero
        output+=$nonzero$buffer
        nonzero=0
        buffer=
    done
    printf '%b' $(printf '\\x%02x' nonzero) | read -ru0 -k1 nonzero
    output+=$nonzero$buffer
    printf '%s' $output
}

function cobs_decode {
    emulate -L zsh
    setopt err_return
    setopt pipe_fail
    setopt NO_multibyte
    setopt NO_unset

    readonly input=$1
    integer i nonzero=1 overhead=1
    local output

    for ((i = 1; i <= ${#input}; i++)); do
        if ((! --nonzero)); then
            ((overhead)) || output+=$'\x00'
            nonzero=$(cobs_bin_to_int $input[$i])
            overhead=$((nonzero == 255))
        else
            output+=$input[$i]
        fi
    done
    if ((--nonzero)); then
        print 'Input too short' >&2
        false
    fi
    printf '%s' $output
}

function cobs_bin_to_int {
    emulate -L zsh
    setopt err_return
    case $1 in
        $'\x00') printf 0 ;;
        $'\x01') printf 1 ;;
        $'\x02') printf 2 ;;
        $'\x03') printf 3 ;;
        $'\x04') printf 4 ;;
        $'\x05') printf 5 ;;
        $'\x06') printf 6 ;;
        $'\x07') printf 7 ;;
        $'\x08') printf 8 ;;
        $'\x09') printf 9 ;;
        $'\x0a') printf 10 ;;
        $'\x0b') printf 11 ;;
        $'\x0c') printf 12 ;;
        $'\x0d') printf 13 ;;
        $'\x0e') printf 14 ;;
        $'\x0f') printf 15 ;;
        $'\x10') printf 16 ;;
        $'\x11') printf 17 ;;
        $'\x12') printf 18 ;;
        $'\x13') printf 19 ;;
        $'\x14') printf 20 ;;
        $'\x15') printf 21 ;;
        $'\x16') printf 22 ;;
        $'\x17') printf 23 ;;
        $'\x18') printf 24 ;;
        $'\x19') printf 25 ;;
        $'\x1a') printf 26 ;;
        $'\x1b') printf 27 ;;
        $'\x1c') printf 28 ;;
        $'\x1d') printf 29 ;;
        $'\x1e') printf 30 ;;
        $'\x1f') printf 31 ;;
        $'\x20') printf 32 ;;
        $'\x21') printf 33 ;;
        $'\x22') printf 34 ;;
        $'\x23') printf 35 ;;
        $'\x24') printf 36 ;;
        $'\x25') printf 37 ;;
        $'\x26') printf 38 ;;
        $'\x27') printf 39 ;;
        $'\x28') printf 40 ;;
        $'\x29') printf 41 ;;
        $'\x2a') printf 42 ;;
        $'\x2b') printf 43 ;;
        $'\x2c') printf 44 ;;
        $'\x2d') printf 45 ;;
        $'\x2e') printf 46 ;;
        $'\x2f') printf 47 ;;
        $'\x30') printf 48 ;;
        $'\x31') printf 49 ;;
        $'\x32') printf 50 ;;
        $'\x33') printf 51 ;;
        $'\x34') printf 52 ;;
        $'\x35') printf 53 ;;
        $'\x36') printf 54 ;;
        $'\x37') printf 55 ;;
        $'\x38') printf 56 ;;
        $'\x39') printf 57 ;;
        $'\x3a') printf 58 ;;
        $'\x3b') printf 59 ;;
        $'\x3c') printf 60 ;;
        $'\x3d') printf 61 ;;
        $'\x3e') printf 62 ;;
        $'\x3f') printf 63 ;;
        $'\x40') printf 64 ;;
        $'\x41') printf 65 ;;
        $'\x42') printf 66 ;;
        $'\x43') printf 67 ;;
        $'\x44') printf 68 ;;
        $'\x45') printf 69 ;;
        $'\x46') printf 70 ;;
        $'\x47') printf 71 ;;
        $'\x48') printf 72 ;;
        $'\x49') printf 73 ;;
        $'\x4a') printf 74 ;;
        $'\x4b') printf 75 ;;
        $'\x4c') printf 76 ;;
        $'\x4d') printf 77 ;;
        $'\x4e') printf 78 ;;
        $'\x4f') printf 79 ;;
        $'\x50') printf 80 ;;
        $'\x51') printf 81 ;;
        $'\x52') printf 82 ;;
        $'\x53') printf 83 ;;
        $'\x54') printf 84 ;;
        $'\x55') printf 85 ;;
        $'\x56') printf 86 ;;
        $'\x57') printf 87 ;;
        $'\x58') printf 88 ;;
        $'\x59') printf 89 ;;
        $'\x5a') printf 90 ;;
        $'\x5b') printf 91 ;;
        $'\x5c') printf 92 ;;
        $'\x5d') printf 93 ;;
        $'\x5e') printf 94 ;;
        $'\x5f') printf 95 ;;
        $'\x60') printf 96 ;;
        $'\x61') printf 97 ;;
        $'\x62') printf 98 ;;
        $'\x63') printf 99 ;;
        $'\x64') printf 100 ;;
        $'\x65') printf 101 ;;
        $'\x66') printf 102 ;;
        $'\x67') printf 103 ;;
        $'\x68') printf 104 ;;
        $'\x69') printf 105 ;;
        $'\x6a') printf 106 ;;
        $'\x6b') printf 107 ;;
        $'\x6c') printf 108 ;;
        $'\x6d') printf 109 ;;
        $'\x6e') printf 110 ;;
        $'\x6f') printf 111 ;;
        $'\x70') printf 112 ;;
        $'\x71') printf 113 ;;
        $'\x72') printf 114 ;;
        $'\x73') printf 115 ;;
        $'\x74') printf 116 ;;
        $'\x75') printf 117 ;;
        $'\x76') printf 118 ;;
        $'\x77') printf 119 ;;
        $'\x78') printf 120 ;;
        $'\x79') printf 121 ;;
        $'\x7a') printf 122 ;;
        $'\x7b') printf 123 ;;
        $'\x7c') printf 124 ;;
        $'\x7d') printf 125 ;;
        $'\x7e') printf 126 ;;
        $'\x7f') printf 127 ;;
        $'\x80') printf 128 ;;
        $'\x81') printf 129 ;;
        $'\x82') printf 130 ;;
        $'\x83') printf 131 ;;
        $'\x84') printf 132 ;;
        $'\x85') printf 133 ;;
        $'\x86') printf 134 ;;
        $'\x87') printf 135 ;;
        $'\x88') printf 136 ;;
        $'\x89') printf 137 ;;
        $'\x8a') printf 138 ;;
        $'\x8b') printf 139 ;;
        $'\x8c') printf 140 ;;
        $'\x8d') printf 141 ;;
        $'\x8e') printf 142 ;;
        $'\x8f') printf 143 ;;
        $'\x90') printf 144 ;;
        $'\x91') printf 145 ;;
        $'\x92') printf 146 ;;
        $'\x93') printf 147 ;;
        $'\x94') printf 148 ;;
        $'\x95') printf 149 ;;
        $'\x96') printf 150 ;;
        $'\x97') printf 151 ;;
        $'\x98') printf 152 ;;
        $'\x99') printf 153 ;;
        $'\x9a') printf 154 ;;
        $'\x9b') printf 155 ;;
        $'\x9c') printf 156 ;;
        $'\x9d') printf 157 ;;
        $'\x9e') printf 158 ;;
        $'\x9f') printf 159 ;;
        $'\xa0') printf 160 ;;
        $'\xa1') printf 161 ;;
        $'\xa2') printf 162 ;;
        $'\xa3') printf 163 ;;
        $'\xa4') printf 164 ;;
        $'\xa5') printf 165 ;;
        $'\xa6') printf 166 ;;
        $'\xa7') printf 167 ;;
        $'\xa8') printf 168 ;;
        $'\xa9') printf 169 ;;
        $'\xaa') printf 170 ;;
        $'\xab') printf 171 ;;
        $'\xac') printf 172 ;;
        $'\xad') printf 173 ;;
        $'\xae') printf 174 ;;
        $'\xaf') printf 175 ;;
        $'\xb0') printf 176 ;;
        $'\xb1') printf 177 ;;
        $'\xb2') printf 178 ;;
        $'\xb3') printf 179 ;;
        $'\xb4') printf 180 ;;
        $'\xb5') printf 181 ;;
        $'\xb6') printf 182 ;;
        $'\xb7') printf 183 ;;
        $'\xb8') printf 184 ;;
        $'\xb9') printf 185 ;;
        $'\xba') printf 186 ;;
        $'\xbb') printf 187 ;;
        $'\xbc') printf 188 ;;
        $'\xbd') printf 189 ;;
        $'\xbe') printf 190 ;;
        $'\xbf') printf 191 ;;
        $'\xc0') printf 192 ;;
        $'\xc1') printf 193 ;;
        $'\xc2') printf 194 ;;
        $'\xc3') printf 195 ;;
        $'\xc4') printf 196 ;;
        $'\xc5') printf 197 ;;
        $'\xc6') printf 198 ;;
        $'\xc7') printf 199 ;;
        $'\xc8') printf 200 ;;
        $'\xc9') printf 201 ;;
        $'\xca') printf 202 ;;
        $'\xcb') printf 203 ;;
        $'\xcc') printf 204 ;;
        $'\xcd') printf 205 ;;
        $'\xce') printf 206 ;;
        $'\xcf') printf 207 ;;
        $'\xd0') printf 208 ;;
        $'\xd1') printf 209 ;;
        $'\xd2') printf 210 ;;
        $'\xd3') printf 211 ;;
        $'\xd4') printf 212 ;;
        $'\xd5') printf 213 ;;
        $'\xd6') printf 214 ;;
        $'\xd7') printf 215 ;;
        $'\xd8') printf 216 ;;
        $'\xd9') printf 217 ;;
        $'\xda') printf 218 ;;
        $'\xdb') printf 219 ;;
        $'\xdc') printf 220 ;;
        $'\xdd') printf 221 ;;
        $'\xde') printf 222 ;;
        $'\xdf') printf 223 ;;
        $'\xe0') printf 224 ;;
        $'\xe1') printf 225 ;;
        $'\xe2') printf 226 ;;
        $'\xe3') printf 227 ;;
        $'\xe4') printf 228 ;;
        $'\xe5') printf 229 ;;
        $'\xe6') printf 230 ;;
        $'\xe7') printf 231 ;;
        $'\xe8') printf 232 ;;
        $'\xe9') printf 233 ;;
        $'\xea') printf 234 ;;
        $'\xeb') printf 235 ;;
        $'\xec') printf 236 ;;
        $'\xed') printf 237 ;;
        $'\xee') printf 238 ;;
        $'\xef') printf 239 ;;
        $'\xf0') printf 240 ;;
        $'\xf1') printf 241 ;;
        $'\xf2') printf 242 ;;
        $'\xf3') printf 243 ;;
        $'\xf4') printf 244 ;;
        $'\xf5') printf 245 ;;
        $'\xf6') printf 246 ;;
        $'\xf7') printf 247 ;;
        $'\xf8') printf 248 ;;
        $'\xf9') printf 249 ;;
        $'\xfa') printf 250 ;;
        $'\xfb') printf 251 ;;
        $'\xfc') printf 252 ;;
        $'\xfd') printf 253 ;;
        $'\xfe') printf 254 ;;
        $'\xff') printf 255 ;;
        *) false ;;
    esac
}
