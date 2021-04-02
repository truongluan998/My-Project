package vn.aptech.cityguide.HelperClasses.HomeAdapter;

import android.widget.ImageView;

public class CategoriesHelperClass {

    private int image;
    private String title;

    public CategoriesHelperClass() {
    }

    public CategoriesHelperClass(int image, String title) {
        this.image = image;
        this.title = title;
    }

    public int getImage() {
        return image;
    }

    public void setImage(int image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
