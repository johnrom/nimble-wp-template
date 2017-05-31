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
}

nimble_wp_install "$project"
