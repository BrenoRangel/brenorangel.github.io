export dir=$( cd ${0%/*} && pwd -P )
tee < $dir/env.sh -a /etc/profile.d/env.sh

# curl -sL https://firebase.tools | bash
# dart pub global activate flutterfire_cli
# firebase login

flutter packages get