---
title: Embedded mobile and Wireless System
date: 2023-01-20 14:48:35
tags:
 - 2022-2023
categories: 
 - academic material
---

code example: (https://pipirima.top/2022-2023/Embedded-mobile-and-Wireless-System-Code-Example-7273817ad39d/)

# initialization
APP: Android Studio v.2020.3.1.26 Patch4, published at December 8, 2021
(https://developer.android.com/studio/archive) please note: Change to English language or may not find this version
language: JAVA
Minimum SDK platform: Android 9 (pie)

tools -> SDK manger
SDK tools: Android SDK build, Android Emulator, Android SDK platform (tool), (optional) HAXM installer

tools -> AVD manager
Harware: Phone-Pixle 2
the emulator can be actived after build. If terminated, please check device's virtual device support.

![000.png](000.png)

one group of xml page have sutomatically initialized when creating a new project.
MainActivity (logic code) and activity_main.xml (page design)
![001.png](001.png)

and a "Hello Word" programe is already coded, can directly ran the programe and test the setting.

# Usual parameter values
## Common parameters
``` Bash
android:text="text"

android:layout_width="wrap_content"
android:layout_height="wrap_content"

app:layout_constraintBottom_toBottomOf="parent"
app:layout_constraintEnd_toEndOf="parent"
app:layout_constraintStart_toStartOf="parent"
app:layout_constraintTop_toTopOf="parent"
```

## set veiwText's value
``` bash
//in .java
TextView your_view_name=findViewById(R.id.your_view_id); // find target textView
String message=your_view_name.getText().toString(); // get written string in this EditText 
your_view_name.setText(message); // input message to textView

//in .xml
android:id="@+id/your_view_name"
```

## Special parametres
``` Bash
Edit Text:
android:id="@+id/editTextTextPersonName"
android:hint="@string/edit_message"

Button:
android:id="@+id/button"
android:onClick="sendMessage" // behavier function name
```

## Sensors
``` Bash
private SensorManager sensorManager; // control all msensors
private Sensor sensorName; // represent a sensor

@Override
//initialize
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        sensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        sensorName = sensorManager.getDefaultSensor(Sensor.%sensorType%);

        //start listener
        sensorManager.registerListener(this,sensorName,UI); //NORMAL:1, UI:2, GAME:3
    }

@Override
//get value
    public void onSensorChanged(SensorEvent event) {
        if (event.sensor.getType() == Sensor.%sensorType%) //target sensor type
            sensorName = event.values;
    }

@Override
//stop listener
    protected void onPause() {
        super.onPause();
        sensormanager.unregisterListener(this);
    }

@Override
//restart listener
    protected void onResume() {
        super.onResume();
        sensorManager.registerListener(this,sensorName,UI); //NORMAL:1, UI:2, GAME:3
    }
```

|Name|sensorType|
|:----|:----|
|MagneticField|Sensor.TYPE_MAGNETIC_FIELD|
|Accelerometer|Sensor.TYPE_ACCELEROMETER|
|Gyroscope|Sensor.TYPE_GYROSCOPE|
|StepCounter|Sensor.TYPE_STEP_DETECTOR|

## WIFI
``` Bash
WifiManager wifiManager;
wifiManager = (WifiManager) getApplicationContext().getSystemService(Context.WIFI_SERVICE);

wifiManager.setWifiEnabled(true);
wifiManager.startScan();

List<ScanResult> wifiScanList = wifiManager.getScanResults();
```

## BlueTooth
``` Bash
//varibale to hold BluetoothAdapter instance
private BluetoothAdapter BA;
//display list of paired Bluetooth device
private Set<BluetoothDevice> pairedDevices;

BA = BluetoothAdapter.getDefaultAdapter();

//get list
pairedDevices = BA.getBondedDevices();
```

## Location
note the "onLocationChanged" will not be changes swiftly
``` Bash
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);

    LocationManager locationManager;
    LocationListener locationListener;

    locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
    locationListener = new mylocationlistener();
}

class mylocationlistener implements  LocationListener{
    @Override
    // called when location  PGS changes
    public void onLocationChanged(@NonNull Location location) {
        if (location != null) {
            ...
        }
    }
}
```

## Map Location and Mark
``` Bash
//be called when Map page is initialized ready
public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;

        // Add a marker in Sydney and move the camera
        LatLng Edinburgh = new LatLng(55.953251, -3.188267);
        //add new markers
        mMap.addMarker(new MarkerOptions().position(Edinburgh).title("Marker in Edinburgh"));
        //move the center of camera to marker
        mMap.moveCamera(CameraUpdateFactory.newLatLng(Edinburgh));

        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        //enable the location button, move the sign to your current place
        mMap.setMyLocationEnabled(true);

        mMap.setMapType(GoogleMap.MAP_TYPE_HYBRID);
        mMap.getUiSettings().setCompassEnabled(true);
        mMap.getUiSettings().setRotateGesturesEnabled(true);
        mMap.getUiSettings().setScrollGesturesEnabled(true);
        mMap.getUiSettings().setTiltGesturesEnabled(true);
    }
```

## Camera
the photo parameters are passed by intent
Please move to (https://pipirima.top/2022-2023/Embedded-mobile-and-Wireless-System-Code-Example-7273817ad39d/#Camera) to check how to take and save a picture

# usful code group
## intent
``` bash
//in main class
intent intent=new Intent(this,New_class.class); // create an intent class which will communicated with new class
intent.putExtra('extras_name', 'your_message'); // put the string into EXTRA_MESSAGE.
startActivity (intent); // running intent

//in new class
Intent intent=getIntent();
string message=intent.getStringExtra('extras_name');// message will get string value
//you can use intent.getIntExtra('extras_name') to get integer value
```

## read battery states
``` bash
private IntentFilter ifilter;
//in OnCreate
ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED); //ifilter have matched with a type of action
registerReceiver(mBatInforReceiver,ifilter); //the receiver will be called when any broadcast matches filter

//in mBatInforReceiver
String action = intent.getAction();
if (Intent.ACTION_BATTERY_CHANGED.equals(action)){
    BatteryL=intent.getIntExtra("level",0);
    ...
}
```

|String|Constant Value|
|:----|:----|
|EXTRA_LEVEL|level|
|EXTRA_VOLTAGE|voltage|
|EXTRA_TEMPERATURE|temperature|
|EXTRA_TECHNOLOGY|technology|

|EXTRA_STATUS|status|
|:----|:----|
|BATTERY_STATUS_CHARGING|2 (0x00000002)|
|BATTERY_STATUS_DISCHARGING|3 (0x00000003)|
|BATTERY_STATUS_NOT_CHARGING|4 (0x00000004)|
|BATTERY_STATUS_FULL|5 (0x00000005)|
|BATTERY_STATUS_UNKNOWN|1 (0x00000001)|

|EXTRA_PLUGGED|plugged|
|:----|:----|
|BATTERY_PLUGGED_AC|1 (0x00000001)|
|BATTERY_PLUGGED_USB|2 (0x00000002)|
|BATTERY_PLUGGED_WIRELESS|4 (0x00000004)|

|EXTRA_HEALTH|health|
|:----|:----|
|BATTERY_HEALTH_UNKNOWN|1 (0x00000001)|
|BATTERY_HEALTH_GOOD|2 (0x00000002)|
|BATTERY_HEALTH_DEAD|4 (0x00000004)|
|BATTERY_HEALTH_OVER_VOLTAGE|5 (0x00000005)|
|BATTERY_HEALTH_OVERHEAT|3 (0x00000003)|

## create onclick event on View
``` Bash
imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //your code
            }
        });
```

## count down timer
``` Bash
CountDownTimer countDownTimer = new CountDownTimer(500, 1000) {

        public void onTick(long millisUntilFinished) {
            // do something after 0.5s
        }

        public void onFinish() {
            // do something end after 1s
            start(); //restart the timer
        }
    };
```

## permission
``` Bash
//in AndroidManifest.xml, in <manifest>
<uses-permission android:name="android.permission.XXXX" />

//in main.java
private static final int REQUEST_ID_READ_WRITE_PERMISSION = 99;

@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        if (Build.VERSION.SDK_INT >= 23) {
            //check if we have read or write permission
            int myPermission = ActivityCompat.checkSelfPermission(this, Manifest.permission.XXXX);
        }

        if (myPermission != PackageManager.PERMISSION_GRANTED) {
                //prompt the user if dont have permission
                this.requestPermissions(
                        new String[]{Manifest.permission.XXXX},
                        REQUEST_ID_READ_WRITE_PERMISSION
                );
                return;
                    }
    }

//When you have the request results
    @Override
    public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case REQUEST_ID_READ_WRITE_PERMISSION: {
                //(read and write and camera) permissions granted
                if (grantResults.length > 1 &&
                        grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    Toast.makeText(this, "Permission granted!", Toast.LENGTH_LONG).show();
                }
                //cancelled or denied
                else {
                    Toast.makeText(this, "Permission denied", Toast.LENGTH_LONG).show();
                }
                break;
            }
        }
    }
```

# tips
## linked Strings
in res -> values -> strings.xml, we can set some default variable strings, in form like
``` Bash
<resources>
    <string name="app_name">My Application</string>
    <string name="edit_message">Enter a message</string>
    <string name="button_send">Send</string>
</resources>
```
![001.png](001.png)
this code is like:
``` Bash
android:hint="@string/edit_message" // which shows "Enter a message" in layout
```

## Google Map API
goto (https://developers.google.com/maps/documentation/android/start#get-key), get Google API
copy API code, copy to file "res/values/google_maps_api.xml"
``` Bash
<string name="google_maps_key" templateMergeStrategy="preserve" translatable="false">"Copy API Here"</string>
```