nimble_wp_init(){
    local dir="."
    local inner_dir="/var/www/html"

    if [[ -z "$project" ]]; then
        echo "Please enter a project to initialize! e.g. nimble init myproject"
        return
    fi

    if is_root; then
        local dir="$site_root/$project/www"
    fi

    if confirm "Would you like to clone a repo?" Y; then
        ask repo "Enter the Github repo (e.g., johnrom/nimble-wp-template)" "" --required

        if [[ ! -z "$repo" ]]; then
            echo "Cloning git@github.com:$repo.git ..."
            clone "$project" "git@github.com:$repo.git"
        fi
    else
        if confirm "Clone NimbleBones?" Y; then
            clone $project "git@github.com:nimblelight/nimblebones.git"
        fi
    fi

    if [ -f "$dir/package.json" ]; then
        cd "$dir" && npm_install
        cd -
    fi

    local url="$project.$tld"

    if confirm "Would you like to install WordPress?" Y; then
        echo "Installing WP to $dir -> $url"

        ask title "Site Title" "$project"
        ask user "Admin User" "admin" --required
        ask password "Admin Password" "password" --required
        ask email "Admin Email" "$(git config user.email)" --required

        echo "Waiting for WordPress at $dir/wp-config.php"
        while [ ! -f $dir/wp-config.php ]
        do
            sleep 2
        done

        echo "Installing WordPress. This could take a few seconds..."

        until wp "$project" core install --path="'$inner_dir'" --url="'$url'" --title="'$title'" --admin_user="'$user'" --admin_password="'$password'" --admin_email="'$email'" --skip-email
        do
            echo "WP Install Failed. Retrying..."
            sleep 2
        done
    fi
}

nimble_wp_init "$project"
