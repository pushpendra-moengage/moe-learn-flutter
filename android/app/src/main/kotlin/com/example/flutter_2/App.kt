package com.example.flutter_2

import android.app.Application
import com.moengage.core.LogLevel
import com.moengage.core.MoEngage
import com.moengage.core.config.LogConfig
import com.moengage.core.model.SdkState
import com.moengage.flutter.MoEInitializer

class App: Application() {

    lateinit var moEngage: MoEngage.Builder

    override fun onCreate() {
        super.onCreate()
        moEngage = MoEngage.Builder(this, "8SIW681S80Z08KSHQFSTIZ8T")
        moEngage.configureLogs( LogConfig(LogLevel.VERBOSE, true))
        MoEInitializer.initialiseDefaultInstance(this, moEngage, SdkState.ENABLED)

    }
}