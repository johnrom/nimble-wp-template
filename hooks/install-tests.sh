
# requires project name
if [[ -z "$1" ]]; then
    echo "You need to provide the project to scaffold tests for! e.g., nimble create-tests project plugin plugin-name"
    exit 1
fi

# requires type (plugin or theme)
if [[ -z "$2" ]]; then
    echo "You need to provide the type of tests to create! e.g., nimble create-tests project plugin plugin-name"
    exit 1
fi

# requires plugin/theme name
if [[ -z "$3" ]]; then
    echo "You need to provide the $2 name! e.g., nimble create-tests project plugin plugin-name"
    exit 1
fi

local type=$4
local name=$5
local inner_dir="/var/www/html"

if [ ! -d "$site_root/$project" ]; then
    echo "Project $project does not exist"
    exit 1
fi

if [ ! -d "$site_root/$project/www/wp-content/${type}s/$name/tests" ]; then
    echo "$project's $type $name's tests haven't been created yet!"
    exit 1
fi

bashitup $project "export WP_CORE_DIR=$inner_dir && cd $inner_dir/wp-content/""$type""s/$name && export WP_TESTS_DIR=./tests/mock && ./bin/install-wp-tests.sh wordpress-tests root example mysql"
