db = db.getSiblingDB('go2super');
db.createCollection('users');
db.createCollection('sessions');
db.createCollection('planets');
print('Base de datos inicializada');