function mpv-review
    set -l command_name $argv[1]
    set -l sort_field $argv[2]
    set -e argv[1..2]

    set -l directory .
    if set -q argv[1]; and not string match -q -- '-*' $argv[1]
        set directory $argv[1]
        set -e argv[1]
    end
    if not test -d "$directory"
        printf 'Not a directory: %s\n' "$directory" >&2
        return 1
    end
    if not string match -q '/*' -- "$directory"
        set directory "$PWD/$directory"
    end

    set -l sorted_files (mktemp); or return
    find "$directory" -type f -printf "$sort_field\t%p\0" | LC_ALL=C sort -z -t \t -k1,1nr | cut -z -f2- > "$sorted_files"
    set -l pipeline_status $pipestatus
    for command_status in $pipeline_status
        if test $command_status -ne 0
            rm -f "$sorted_files"
            return $command_status
        end
    end
    set -l files (string split0 < "$sorted_files")
    rm -f "$sorted_files"
    if not set -q files[1]
        return 0
    end

    set -l state_home "$HOME/.local/state"
    if set -q XDG_STATE_HOME[1]; and test -n "$XDG_STATE_HOME"
        set state_home "$XDG_STATE_HOME"
    end
    set -l watch_later_directory "$state_home/$command_name/watch_later"
    mkdir -p "$watch_later_directory"; or return
    mpv --mute --loop --watch-later-directory="$watch_later_directory" $argv -- $files
end

function mpv-new
    mpv-review mpv-new '%T@' $argv
end

function mpv-big
    mpv-review mpv-big '%s' $argv
end
