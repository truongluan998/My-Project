package vn.aptech.cityguide.HelperClasses.HomeAdapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

import vn.aptech.cityguide.R;

public class CategoriesAdapter  extends RecyclerView.Adapter<CategoriesAdapter.AdapterAllCategoriesViewHolder> {

    ArrayList<CategoriesHelperClass> mostViewedLocations;

    public CategoriesAdapter(ArrayList<CategoriesHelperClass> mostViewedLocations) {
        this.mostViewedLocations = mostViewedLocations;
    }

    @NonNull
    @Override
    public CategoriesAdapter.AdapterAllCategoriesViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.categories_card_design, parent, false);
        AdapterAllCategoriesViewHolder lvh = new AdapterAllCategoriesViewHolder(view);
        return lvh;
    }

    @Override
    public void onBindViewHolder(@NonNull CategoriesAdapter.AdapterAllCategoriesViewHolder holder, int position) {
        CategoriesHelperClass helperClass = mostViewedLocations.get(position);
        holder.imageView.setImageResource(helperClass.getImage());
        holder.textView.setText(helperClass.getTitle());
    }

    @Override
    public int getItemCount() {
        return mostViewedLocations.size();
    }

    public static class AdapterAllCategoriesViewHolder extends RecyclerView.ViewHolder {

        ImageView imageView;
        TextView textView;

        public AdapterAllCategoriesViewHolder(@NonNull View itemView) {
            super(itemView);

            imageView = itemView.findViewById(R.id.categories_image);
            textView = itemView.findViewById(R.id.categories_title);
        }
    }
}
