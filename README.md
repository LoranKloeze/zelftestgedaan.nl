### Broncode for www.zelftestgedaan.nl


Dit is een Ruby on Rails applicatie. Mocht je daar geen ervaring mee hebben dan raad ik aan om eerst een tutorial te volgen voordat je hiermee aan de slag gaat.


## Dev-omgeving

* Zorg dat je via rbenv een ruby-omgeving hebt. 
* Zorg dat je een postgresql-server hebt draaien
* Pull deze repo naar een directory.
* Check config/database.yml voor development/test de juiste databasecredentials heeft
* $ bin/rails db:migrate
* $ bin/rails test <- moet foutloos runnen
* $ bin/rails s 
* Nu heb je een lokale server draaien op localhost:3000

## Assets
De assets worden ingepakt met webpacker. De scss-bestanden staan in app/javascript/stylesheets.
Webpack compiled automatisch bij de eerstvolgende reqeust en cached het.
