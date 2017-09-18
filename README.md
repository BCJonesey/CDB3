LARP Management Tool[![Build Status](https://secure.travis-ci.org/CerberusBen/CDB3.png?branch=master)](http://travis-ci.org/CerberusBen/CDB3)
=============================================================================================================================================
*Simplilfing logistics cuz that's not the fun part*




docker-compose exec web foreman run bundle exec rails c


heroku pg:backups:capture && heroku pg:backups:download && docker-compose exec web pg_restore --verbose --clean --no-acl --no-owner -h db -d cdb3_development -U postgres latest.dump && rm latest.dump
