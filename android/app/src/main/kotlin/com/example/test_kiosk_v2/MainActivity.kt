package com.example.reward_center_kiosk

import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.media.MediaPlayer
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import com.tx.printlib.Const
import com.tx.printlib.UsbPrinter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream


enum class PrinterFont(val assetPath: String) {
    DEFAULT(""),
    ROMANESCO_REGULAR("fonts/Romanesco-Regular.ttf"),
 }


class MainActivity : FlutterActivity()  {
    private val PRINTER_CHANNEL = "printer_channel"
    private val logTag = MainActivity::class.java.simpleName
    private var mUsbPrinter: UsbPrinter? = null
    private var mediaPlayer: MediaPlayer? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            mUsbPrinter = UsbPrinter(applicationContext)
            Log.d(logTag, "UsbPrinter initialized in onCreate")
        } catch (e: Exception) {
            Log.e(logTag, "UsbPrinter init failed", e)
        }

        // reference it because if not, the app think it's not used. therefore removing it
        // in the build apk release
        val dummy = resources.getIdentifier("claimticket", "raw", packageName)
        val dummy1 = resources.getIdentifier("preprint", "raw", packageName)
        val dummy2 = resources.getIdentifier("welcome", "raw", packageName)
        print("Audio files: , $dummy,$dummy1,$dummy2" )
    } 
fun printColumns(left: String, right: String?, printer: UsbPrinter, leftWidth: Int = 28) { 
    fun getPrintWidth(text: String): Int {
        var width = 0
        for (ch in text) {
            width += if (ch.code > 0xFF) 2 else 1  
        }
        return width
    }
 
    var truncatedLeft = ""
    var currentWidth = 0
    for (ch in left) {
        val charWidth = if (ch.code > 0xFF) 2 else 1
        if (currentWidth + charWidth > leftWidth) break
        truncatedLeft += ch
        currentWidth += charWidth
    }
 
    val paddingSpaces = leftWidth - getPrintWidth(truncatedLeft)
    val paddedLeft = truncatedLeft + " ".repeat(paddingSpaces)
 
    val line = paddedLeft + (right ?: "")
    printer.doFunction(Const.TX_ALIGN, Const.TX_ALIGN_LEFT,0)
    printer.outputString(line)
    printer.newline()
    printer.doFunction(Const.TX_FEED, 8, 0)
}

    fun printTextAsImage(
        printer: UsbPrinter,
        text: String,
        context: Context,
        font: PrinterFont = PrinterFont.DEFAULT,
        textSize: Float = 24f
    ) {
        val typeface = if (font.assetPath.isNotEmpty()) {
            Typeface.createFromAsset(context.assets, font.assetPath)
        } else {
            Typeface.DEFAULT
        }

        val paint = Paint().apply {
            isAntiAlias = true
            color = Color.BLACK
            this.textSize = textSize
            this.typeface = typeface
        }

        val width = paint.measureText(text).toInt().coerceAtLeast(1)
        val height = (paint.fontMetrics.bottom - paint.fontMetrics.top).toInt().coerceAtLeast(1)

        val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)
        canvas.drawText(text, 0f, -paint.fontMetrics.top, paint)

        val tempFile = File(context.cacheDir, "temp_print.png")
        FileOutputStream(tempFile).use { out ->
            bitmap.compress(Bitmap.CompressFormat.PNG, 100, out)
        }

        printer.printImage(tempFile.absolutePath)

        tempFile.delete()
    }

    fun getAssetFilePath(context: Context, assetPath: String): String {
        val tempFile = File(context.cacheDir, File(assetPath).name)
        context.assets.open(assetPath).use { input ->
            FileOutputStream(tempFile).use { output ->
                input.copyTo(output)
            }
        }
        return tempFile.absolutePath
    }

    fun printSolidLine( printer: UsbPrinter ) {
      printer.doFunction(Const.TX_FONT_BOLD, Const.TX_ON, 0)
      printer.outputStringLn("________________________________________________")
      printer.resetFont()
    }
    fun printDashLine( printer: UsbPrinter ) {
            printer.doFunction(Const.TX_FONT_SIZE, Const.TX_SIZE_1X, 0)
            printer.outputStringLn("................................................")
            printer.resetFont()
    }
    fun printCenterText(printer: UsbPrinter, text: String){
        printer.doFunction(Const.TX_ALIGN, Const.TX_ALIGN_CENTER, 0)
        printer.outputStringLn(text);
        printer.resetFont();
    }

    fun printTitle(printer: UsbPrinter, text: String){
        printer.doFunction(Const.TX_ALIGN, Const.TX_ALIGN_CENTER, 0)
        printer.doFunction(Const.TX_SEL_FONT, Const.TX_FONT_A,0)
        printer.doFunction(Const.TX_FONT_SIZE, Const.TX_SIZE_3X,0)
        printer.doFunction(Const.TX_FONT_BOLD, Const.TX_ON, 0)
        printer.outputStringLn( text)
        printer.resetFont()
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PRINTER_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "initPrinter" -> {
                        try {
                            if (mUsbPrinter == null) {
                                mUsbPrinter = UsbPrinter(applicationContext)
                            }
                            result.success("Printer initialize")
                        } catch (e: Exception) {
                            result.error("INIT_FAILED", e.message, null)
                        }
                    }

                    "printTest" -> {
                        try {
                            if (mUsbPrinter == null) {
                                result.error("NOT_INIT", "Printer not initialized", null)
                                return@setMethodCallHandler
                            }

                            val usbManager = getSystemService(Context.USB_SERVICE) as UsbManager
                            val devMap = usbManager.deviceList
                            val device: UsbDevice? = devMap.values.firstOrNull { UsbPrinter.checkPrinter(it) }

                            if (device != null && mUsbPrinter?.open(device) == true) {
                                mUsbPrinter?.apply {
                                    init()
                                    doFunction(Const.TX_LINE_SP, 20, 0)
                                    doFunction(Const.TX_ALIGN, Const.TX_ALIGN_CENTER, 0)
                                    printImage(getAssetFilePath(context, "images/logo.png"))

                                    doFunction(Const.TX_ALIGN, Const.TX_ALIGN_CENTER, 0)
                                    doFunction(Const.TX_FONT_BOLD, Const.TX_ON, 0)
                                    doFunction(Const.TX_FONT_SIZE, Const.TX_SIZE_2X, 0)
                                    outputStringLn("XYZ Casino")
                                    resetFont()

                                    doFunction(Const.TX_FEED, 16, 0)                    // spacing

                                    printCenterText(mUsbPrinter!!, "#79 St.17 Village1 Sangkat #3 Khan Mittapheap, SihaknoukVille, Cambodia.")

                                    doFunction(Const.TX_FEED, 32, 0)                    // spacing

                                    printTitle(mUsbPrinter!!,"Redemption")

                                    doFunction(Const.TX_FEED, 16, 0)                    // spacing

                                    doFunction(Const.TX_BARCODE_HEIGHT, 32, 0);
                                    printBarcode(Const.TX_BAR_UPCA, "12345678901");
                                    doFunction(Const.TX_FEED, 42, 0)

                                    printColumns("Redeem# 兑换编號", "T1104", mUsbPrinter!!);
                                    printColumns("Date 兑换编號", "2025 09 02  06:47", mUsbPrinter!!)
                                    printColumns("Redeem by 兑换人", "SYNC", mUsbPrinter!!);
                                    printColumns("Location 兑换人", "Other", mUsbPrinter!!);

                                    printSolidLine(mUsbPrinter!!)

                                    doFunction(Const.TX_FEED, 16, 0)

                                    printColumns("Member ID 会员编号", "0213", mUsbPrinter!!);
                                    printColumns("Member Name 会员编号", "PLAYER 0213", mUsbPrinter!!)

                                    printDashLine(mUsbPrinter!!)
                                    doFunction(Const.TX_FEED, 8, 0)

                                    outputStringLn("Redeem 10 pts = 1\$ Skybar F&B")

                                    printDashLine(mUsbPrinter!!)
                                    doFunction(Const.TX_FEED, 16, 0)

                                    printColumns("Point Balance 积分余额", "136.95 pts", mUsbPrinter!!);
                                    printColumns("Balance at 截至日期余额", "2025 09 10 1:37 pm", mUsbPrinter!!)

                                    // End of page (feed for better spacing)
                                    doFunction(Const.TX_FEED, 140, 200)
                                    doFunction(Const.TX_FEED, 140, 0)

                                    doFunction(Const.TX_CUT, Const.TX_CUT_PARTIAL, 0)
                                    close()
                                }
                                result.success("Print success")
                            } else {
                                result.error("NO_DEVICE", "No USB printer found or open failed.", null)
                            }

                        } catch (e: Exception) {
                            result.error("PRINT_FAILED", e.message, null)
                        }
                    } 

                    "playAudio" -> {
                        try {
                           val filename = call.argument<String>("file")
 
                            val resId = resources.getIdentifier(filename, "raw", packageName)
                            if (resId == 0) {
                                result.error("NOT_FOUND", "Audio file not found: $filename", null)
                                return@setMethodCallHandler
                            }

                            mediaPlayer?.stop()
                            mediaPlayer?.release()

                            mediaPlayer = MediaPlayer.create(this, resId)
                            mediaPlayer?.start()

                            mediaPlayer?.setOnCompletionListener { mp ->
                                mp.release()
                                mediaPlayer = null
                            }

                            result.success(null)
                        } catch (e: Exception) {
                            result.error("PLAY_ERROR", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }
}
