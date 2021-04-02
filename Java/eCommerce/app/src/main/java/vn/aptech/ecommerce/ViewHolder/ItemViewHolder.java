package vn.aptech.ecommerce.ViewHolder;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import vn.aptech.ecommerce.Interface.ItemClickListner;
import vn.aptech.ecommerce.R;

public class ItemViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {

    public TextView txtProductName, txtProductDescription, txtProductPrice, txtProductStatus;
    public ImageView imageView;
    public ItemClickListner listner;

    public ItemViewHolder(@NonNull View itemView) {
        super(itemView);

        imageView = itemView.findViewById(R.id.product_seller_image);
        txtProductName = itemView.findViewById(R.id.product_seller_name);
        txtProductDescription = itemView.findViewById(R.id.product_seller_description);
        txtProductPrice = itemView.findViewById(R.id.product_seller_price);
        txtProductStatus = itemView.findViewById(R.id.product_seller_state);

    }

    public void setItemClickListner(ItemClickListner listner) {
        this.listner = listner;
    }

    @Override
    public void onClick(View view) {
        listner.onClick(view, getAdapterPosition(), false);
    }
}
