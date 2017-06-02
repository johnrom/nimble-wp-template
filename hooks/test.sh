
# requires project name
if [[ -z "$2" ]]; then
    echo "You need to provide the type of tests to create! e.g., nimble test project plugin plugin-name"
    exit 1
fi

# requires project name
if [[ -z "$3" ]]; then
    echo "You need to provide the $2 name! e.g., nimble create-tests project plugin plugin-name"
    exit 1
fi

local type="$2"
local name="$3"
local inner_dir="/var/www/html"

bashitup "$project" "export WP_CORE_DIR=$inner_dir/ && cd $inner_dir/wp-content/${type}s/$name && export WP_TESTS_DIR=./tests/mock && phpunit ${*:4}"