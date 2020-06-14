# bundle exec rails new app --skip-test --database=postgresql --api --skip-sprockets --skip-spring --skip-active-storage 
# add --skip-active-record for mongoid

with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "ruby-env";
  buildInputs = [
    ruby_2_7
    zlib
    postgresql
  ];
}
