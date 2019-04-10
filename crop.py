import mysql.connector as mysql
import serial
import json


def get_recommendation(data):
    # actual values in the sensor
    temperature_value = data['temperature']
    humidity_value = data['humidity']
    soil_moisture_value = data['moisture']
    soil_ph_value = data['ph']

    query = "SELECT * FROM cropdetails;"
    cursor.execute(query)
    values = cursor.fetchall()
    min_diff = 500
    crop = ""

    for value in values:
        temp_diff = abs(value[2] - temperature_value)
        ph_diff = abs(value[3] - soil_ph_value)
        moisture_diff = abs(value[4] - soil_moisture_value)
        humidity_diff = abs(value[5] - humidity_value)
        total_diff = abs(temp_diff + ph_diff + moisture_diff + humidity_diff)

        if total_diff < min_diff:
            min_diff = total_diff
            crop = value[1]

    return crop


if __name__ == "__main__":
    db = mysql.connect(
        host="localhost",
        user="root",
        passwd="",
        database="crops2"
    )

    cursor = db.cursor(buffered=True)

    arduino = serial.Serial('COM10', 115200, timeout=.1)

    while True:
        data = arduino.readline()  # the last bit gets rid of the new-line chars
        if data:
            try:
                data = json.loads(data)
                if data['readComplete']:
                    print(get_recommendation(data))
            except json.decoder.JSONDecodeError as error:
                pass
