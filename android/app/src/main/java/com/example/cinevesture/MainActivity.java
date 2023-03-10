package com.example.cinevesture;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.content.ComponentName;


import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

//        Intent intent=new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
//        intent.addCategory("android.intent.category.DEFAULT");
//        intent.setData(Uri.parse(String.format("package:%s",getApplicationContext().getPackageName())));
//        startActivityIfNeeded(intent,100);
    }
}
