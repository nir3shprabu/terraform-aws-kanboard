#!/bin/bash
set -e
sudo apt install postgresql postgresql-contrib -y
sudo systemctl start postgresql.service
sudo apt install postgresql-client -y
sudo sed -i '89 , 94 s/peer/trust/g' /etc/postgresql/14/main/pg_hba.conf
sudo sed -i 's/localhost/0.0.0.0/g' /etc/postgresql/14/main/postgresql.conf
echo "local docker docker trust" | sudo tee -a /etc/postgresql/14/main/pg_hba.conf
sudo systemctl restart postgresql.service

psql -v ON_ERROR_STOP=1 --username "postgres" <<-EOSQL
	CREATE USER kanban;
	ALTER USER kanban PASSWORD 'mypassword';
	CREATE DATABASE kanban;
	GRANT ALL PRIVILEGES ON DATABASE kanban TO kanban;
	ALTER DATABASE "kanban" OWNER TO "kanban";
EOSQL
