function fish_greeting
    echo -ne '\x1b[38;5;16m'  # Set colour to primary
    echo '    ___       ___       ___       ___   '
    echo '   /\  \     /\  \     /\  \     /\__\  '
    echo '  /::\  \   /::\  \   /::\  \   /:/__/_ '
    echo ' /::\:\__\ /::\:\__\ /:/\:\__\ /::\/\__\\'
    echo ' \/\::/  / \;:::/  / \:\ \/__/ \/\::/  /'
    echo '   /:/  /   |:\/__/   \:\__\     /:/  / '
    echo '   \/__/     \|__|     \/__/     \/__/  '
    echo '                                        '
    set_color normal
    fastfetch --key-padding-left 2
end

#     ___              __  
#    /   |  __________/ /_ 
#   / /| | / ___/ ___/ __ \
#  / ___ |/ /  / /__/ / / /
# /_/  |_/_/   \___/_/ /_/ 
#
