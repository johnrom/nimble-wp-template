
# requires project name
if [[ -z "$3" ]]; then
    echo "You need to provide the project to scaffold tests for! e.g., nimble create-tests project plugin plugin-name"
    exit 1
fi

# requires test type
if [[ -z "$4" ]]; then
    echo "You need to provide the type of tests to create! e.g., nimble create-tests project plugin plugin-name"
    exit 1
fi

# requires project name
if [[ -z "$5" ]]; then
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

bashitup $project "export WP_CORE_DIR=$inner_dir && export WP_TESTS_DIR=./tests/mock && wp scaffold $type-tests $name"
