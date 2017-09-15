nimble_wp_install(){

    local dir="."
    local inner_dir="/var/www/html"

    if [[ -z "$project" ]]; then
        echo "Please enter a project to install! e.g. nimble install myproject"
        return
    fi

    if is_root; then
        local dir="$site_root/$project/www"
    fi

    local url="$project.$tld"

    # Todo, installing WP moved to init hook
}

nimble_wp_install "$project"
