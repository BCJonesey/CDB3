LARP Management Tool[![Build Status](https://secure.travis-ci.org/CerberusBen/CDB3.png?branch=master)](http://travis-ci.org/CerberusBen/CDB3)
=============================================================================================================================================
*Simplilfing logistics cuz that's not the fun part*



It's in rails 3.1 or something like that


== Setting up Insecure Postgres Databases ==

sudo apt-get install postgresql libpq-dev
sudo su - postgres
createuser -d -R -S -P cdb3
  password: yooD9zai

sudo kate /etc/postgresql/9.1/main/pg_hba.conf

Comment out these lines:
local   all             all                                     peer
host    all             all             127.0.0.1/32            md5

Add these lines:
local   all             all                                     trust
host    all             all             127.0.0.1/32            trust

sudo service postgresql restart
rake db:create
