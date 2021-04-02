package vn.aptech.cityguide.User;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.view.WindowManager;

import java.util.ArrayList;

import vn.aptech.cityguide.HelperClasses.HomeAdapter.CategoriesAdapter;
import vn.aptech.cityguide.HelperClasses.HomeAdapter.CategoriesHelperClass;
import vn.aptech.cityguide.HelperClasses.HomeAdapter.FeaturedAdapter;
import vn.aptech.cityguide.HelperClasses.HomeAdapter.FeaturedHelperClass;
import vn.aptech.cityguide.HelperClasses.HomeAdapter.MostViewedAdapter;
import vn.aptech.cityguide.HelperClasses.HomeAdapter.MostViewedHelperClass;
import vn.aptech.cityguide.R;

public class UserDashboard extends AppCompatActivity {

    RecyclerView featureRecycler, mostViewedRecycler, categoriesRecycler;
    RecyclerView.Adapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        setContentView(R.layout.activity_user_dashboard);

        featureRecycler = findViewById(R.id.featured_recycle);
        mostViewedRecycler = findViewById(R.id.most_viewed_recycler);
        categoriesRecycler = findViewById(R.id.categories_recycler);

        featureRecycler();
        mostViewedRecycler();
        categoriesRecycler();

    }

    private void categoriesRecycler() {
        ArrayList<CategoriesHelperClass> categoriesHelperClasses = new ArrayList<>();
        categoriesHelperClasses.add(new CategoriesHelperClass( R.drawable.school_img, "Education"));
        categoriesHelperClasses.add(new CategoriesHelperClass( R.drawable.hospital_img, "HOSPITAL"));
        categoriesHelperClasses.add(new CategoriesHelperClass( R.drawable.restaurant_img, "Restaurant"));
        categoriesHelperClasses.add(new CategoriesHelperClass( R.drawable.shopping_img, "Shopping"));
        categoriesHelperClasses.add(new CategoriesHelperClass( R.drawable.transport_img, "Transport"));


        categoriesRecycler.setHasFixedSize(true);
        adapter = new CategoriesAdapter(categoriesHelperClasses);
        categoriesRecycler.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false));
        categoriesRecycler.setAdapter(adapter);
    }

    private void mostViewedRecycler() {

        mostViewedRecycler.setHasFixedSize(true);
        mostViewedRecycler.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false));

        ArrayList<MostViewedHelperClass> mostViewedLocations = new ArrayList<>();
        mostViewedLocations.add(new MostViewedHelperClass(R.drawable.mcdonalds_img, "McDonald's"));
        mostViewedLocations.add(new MostViewedHelperClass(R.drawable.city2, "Edenrobe"));
        mostViewedLocations.add(new MostViewedHelperClass(R.drawable.city1, "J."));
        mostViewedLocations.add(new MostViewedHelperClass(R.drawable.mcdonalds_img, "Walmart"));

        adapter = new MostViewedAdapter(mostViewedLocations);
        mostViewedRecycler.setAdapter(adapter);

    }

    private void featureRecycler() {

        featureRecycler.setHasFixedSize(true);
        featureRecycler.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false));

        ArrayList<FeaturedHelperClass> featuredLocations = new ArrayList<>();

        featuredLocations.add(new FeaturedHelperClass(R.drawable.mcdonalds_img, "Mcdonald's", "McDonald's (MCD) is a fast food, limited service restaurant with more than 35,000 restaurants in over 100 countries. It employs more than four million people."));
        featuredLocations.add(new FeaturedHelperClass(R.drawable.city1, "Edenrobe", "McDonald's (MCD) is a fast food, limited service restaurant with more than 35,000 restaurants in over 100 countries. It employs more than four million people."));
        featuredLocations.add(new FeaturedHelperClass(R.drawable.city2, "Sweet and Bakers", "McDonald's (MCD) is a fast food, limited service restaurant with more than 35,000 restaurants in over 100 countries. It employs more than four million people."));

        adapter = new FeaturedAdapter(featuredLocations);
        featureRecycler.setAdapter(adapter);

    }
}