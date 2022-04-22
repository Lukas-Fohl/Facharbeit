package com.example.kotlin_fa

import android.graphics.*
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.Button
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import androidx.navigation.ui.setupActionBarWithNavController
import com.example.kotlin_fa.databinding.ActivityMainBinding
import java.io.File
import java.io.InputStream


class MainActivity : AppCompatActivity() {

    private lateinit var appBarConfiguration: AppBarConfiguration
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setSupportActionBar(binding.toolbar)

        val navController = findNavController(R.id.nav_host_fragment_content_main)
        appBarConfiguration = AppBarConfiguration(navController.graph)
        setupActionBarWithNavController(navController, appBarConfiguration)

        /*
        binding.fab.setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                    .setAction("Action", null).show()
        }
        */
        val prime = findViewById<Button>(R.id.prime);
        prime.setOnClickListener {
            val numb: MutableList<Int> = mutableListOf(1)
            var yes: Boolean = false
            for (i in 1..200000) {
                yes = false;
                for (x in 2..i)
                {
                    if(i%x==0)
                    {
                        yes = false;
                        break;
                    }else
                    {
                        yes = true;
                    }
                }
                if(yes==true)
                {
                    numb.add(i);
                    yes = false;
                }
            }
            Toast.makeText(this,"prime finished",Toast.LENGTH_SHORT).show();
        }
        val pic = findViewById<Button>(R.id.pic);
        pic.setOnClickListener {
                // get input stream
            val ims: InputStream = assets.open("test.png")
            val bitmap = BitmapFactory.decodeStream(ims)
            var x: Int = 0
            var y: Int = 0
            var res: String = ""
            //Toast.makeText(this,bitmap.getPixel(0,0).toString(),Toast.LENGTH_SHORT).show();
            repeat(bitmap.width)
            {
                //Toast.makeText(this,x.toString(),Toast.LENGTH_SHORT).show();
                repeat(bitmap.width)
                {

                    if(bitmap.getPixel(x,y).toString()=="")
                    {
                        res = (bitmap.getPixel(x,y)*5).toString()
                    }
                    y = y.inc()
                }
                y = 0
                x = x.inc()
            }
            Toast.makeText(this,"pic is done",Toast.LENGTH_SHORT).show();
        }

    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        val navController = findNavController(R.id.nav_host_fragment_content_main)
        return navController.navigateUp(appBarConfiguration)
                || super.onSupportNavigateUp()
    }
}