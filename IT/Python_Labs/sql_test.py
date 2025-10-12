import mysql.connector

# Настройки подключения к базе данных (замени своими)
config = {
    "host": "localhost",
    "user": "root",
    "password": "MmSs$40974097",
    "database": "jokes_database"
}

# Читаем SQL-запрос из файла joke.sql
with open("C:\\mai-university7\\IT\\Python_Labs\\joke.sql", "r", encoding="utf-8") as f:
    sql_query = f.read().format(id=2)

connection = mysql.connector.connect(**config)
cursor = connection.cursor()

cursor.execute(sql_query)

result = cursor.fetchone()
print(result)
# Если в запросе возвращается одна колонка (например, текст шутки)
if result:
    joke = result[0]
    print("Шутка:", joke)
else:
    print("Шутка не найдена")

cursor.close()
connection.close()
