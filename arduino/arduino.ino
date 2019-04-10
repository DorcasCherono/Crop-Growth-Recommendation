#include <LiquidCrystal.h>
#include "DHT.h"

LiquidCrystal lcd(2,3,4,5,6,7); 

#define DHTPIN A1
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

#define SensorPin A5            //pH meter Analog output to Arduino Analog Input 0
#define Offset 1.30            //deviation compensate
#define ArrayLenth  40    //times of collection

int pHArray[ArrayLenth];   //Store the average value of the sensor feedback
int pHArrayIndex=0;
bool readComplete = false;

void setup() {
  lcd.begin(16, 2);
  dht.begin(); 
  Serial.begin(115200);
}

void loop() {
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();

  if (isnan(humidity) || isnan(temperature)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  float moistureSensorValue = analogRead(A0);
  
  static float pHReading,pHValue,voltage;
 
  pHReading = analogRead(SensorPin);
  pHArray[pHArrayIndex++] = pHReading;
  if(pHArrayIndex == ArrayLenth) {
    pHArrayIndex = 0;
    if (!readComplete) readComplete = true;
  }
  voltage = avergearray(pHArray, ArrayLenth)*5.0/1024;
  pHValue = 3.5*voltage+Offset;

  String outputFirst;
  String outputSecond;
  String serialOutput;

  serialOutput = F("{\"humidity\":");
  outputFirst = F("H: ");

  serialOutput += String(humidity, 1);
  outputFirst += String(humidity, 1);
  
  serialOutput += F(",\"temperature\":");
  outputFirst += F(" T: ");
  
  serialOutput += String(temperature, 1);
  outputFirst += String(temperature, 1);
  
  serialOutput += F(",\"moisture\":"); 
  outputSecond = F("M: ");

  serialOutput += String(moistureSensorValue, 1);
  outputSecond += String(moistureSensorValue, 1);

  serialOutput += F(",\"ph\":");
  outputSecond += F(" P: ");

  serialOutput += String(pHValue, 1);
  outputSecond += String(pHValue, 1);

  if (readComplete) {
    serialOutput += F(",\"readComplete\":true}");
  } else {
    serialOutput += F(",\"readComplete\":false}");
  }

  if(Serial.available() > 0) {
    char response[Serial.available() + 1];
    int i;
    for(i = 0; i < Serial.available(); i++){
      response[i]=Serial.read();
    }
    i++;
    response[i]='\0';
    lcd.print(response);
  } else {
    if (readComplete) {
      lcd.print(outputFirst);
      lcd.setCursor(0,1);
      lcd.print(outputSecond);
    } else {
      lcd.print("Loading...");
    }
  }

  Serial.print(serialOutput);

  delay(200);
  lcd.clear();
}

double avergearray(int* arr, int number){
  int i;
  int max,min;
  double avg;
  long amount=0;
  if(number<=0){
    Serial.println("Error number for the array to avraging!/n");
    return 0;
  }
  if(number<5){   //less than 5, calculated directly statistics
    for(i=0;i<number;i++){
      amount+=arr[i];
    }
    avg = amount/number;
    return avg;
  }else{
    if(arr[0]<arr[1]){
      min = arr[0];max=arr[1];
    }
    else{
      min=arr[1];max=arr[0];
    }
    for(i=2;i<number;i++){
      if(arr[i]<min){
        amount+=min;        //arr<min
        min=arr[i];
      }else {
        if(arr[i]>max){
          amount+=max;    //arr>max
          max=arr[i];
        }else{
          amount+=arr[i]; //min<=arr<=max
        }
      }//if
    }//for
    avg = (double)amount/(number-2);
  }//if
  return avg;
}
