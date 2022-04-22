using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;
using Xamarin.Essentials;
using Xamarin.Android.Net;
using Android.App;
using Android.Content.PM;
using SkiaSharp;
using Android.Runtime;
using Android.Graphics.Drawables;
using Android.OS;
using Android.Content.Res;
using Android.Views;
using AndroidX.AppCompat.Widget;
using AndroidX.AppCompat.App;
using Google.Android.Material.FloatingActionButton;
using Google.Android.Material.Snackbar;

namespace App2
{
    [Activity(Label = "@string/app_name", Theme = "@style/AppTheme.NoActionBar", MainLauncher = true)]
    public class MainActivity : AppCompatActivity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            base.OnCreate(savedInstanceState);
            Xamarin.Essentials.Platform.Init(this, savedInstanceState);
            SetContentView(Resource.Layout.activity_main);

            Toolbar toolbar = FindViewById<Toolbar>(Resource.Id.toolbar);
            SetSupportActionBar(toolbar);

            FloatingActionButton fab = FindViewById<FloatingActionButton>(Resource.Id.fab);
            fab.Click += FabOnClick;
            FloatingActionButton fab2 = FindViewById<FloatingActionButton>(Resource.Id.fab2);
            fab2.Click += FabOnClick2;
        }

        public override bool OnCreateOptionsMenu(IMenu menu)
        {
            MenuInflater.Inflate(Resource.Menu.menu_main, menu);
            return true;
        }

        public override bool OnOptionsItemSelected(IMenuItem item)
        {
            int id = item.ItemId;
            if (id == Resource.Id.action_settings)
            {
                return true;
            }

            return base.OnOptionsItemSelected(item);
        }

        private void FabOnClick(object sender, EventArgs eventArgs)
        {
            int no1 = (Int32)(DateTime.Now.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
            int beg = 0;
            int end = 200000;
            bool yes = false;
            List<int> prime = new List<int>();
            int div = Math.Abs(end - beg);
            for (int i = 0; i < div; i++)
            {
                yes = false;
                for (int j = 2; j < i; j++)
                {
                    if (i % j == 0)
                    {
                        yes = false;
                        break;
                    }
                    else
                    {
                        yes = true;
                    }
                }
                if (yes == true)
                {
                    prime.Add(i);
                    yes = false;
                }

            }
            int no2 = (Int32)(DateTime.Now.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
            View view = (View) sender;
            Snackbar.Make(view, (no2 - no1).ToString(), Snackbar.LengthLong)
                .SetAction("Action", (View.IOnClickListener)null).Show();
            System.Diagnostics.Debug.WriteLine(prime.ToString());
        }

        private void FabOnClick2(object sender, EventArgs eventArgs)
        {
            AssetManager assets = Android.App.Application.Context.Assets;
            int no1 = (Int32)(DateTime.Now.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
            string res = "";
            using (var stream = this.Assets.Open(@"test.png"))
            { 
                Android.Graphics.Bitmap bm = Android.Graphics.BitmapFactory.DecodeStream(stream);
                Console.WriteLine("done");
                for (int i = 0;i < bm.Width; i++)
                {
                    for (int y = 0; y < bm.Height; y++)
                    {
                        res = (bm.GetPixel(i,y)*5).ToString();
                    }
                }
            }
            int no2 = (Int32)(DateTime.Now.Subtract(new DateTime(1970, 1, 1))).TotalSeconds;
            View view = (View)sender;
            Snackbar.Make(view, (no2 - no1).ToString(), Snackbar.LengthLong)
                .SetAction("Action", (View.IOnClickListener)null).Show();
        }

        

        public override void OnRequestPermissionsResult(int requestCode, string[] permissions, [GeneratedEnum] Android.Content.PM.Permission[] grantResults)
        {
            Xamarin.Essentials.Platform.OnRequestPermissionsResult(requestCode, permissions, grantResults);

            base.OnRequestPermissionsResult(requestCode, permissions, grantResults);
        }
        
	}
}
