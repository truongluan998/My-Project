package vn.aptech.cityguide.HelperClasses.HomeAdapter;

public class FeaturedHelperClass {

    private int image;
    private String title, descriptions;

    public FeaturedHelperClass() {
    }

    public FeaturedHelperClass(int image, String title, String descriptions) {
        this.image = image;
        this.title = title;
        this.descriptions = descriptions;
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

    public String getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(String descriptions) {
        this.descriptions = descriptions;
    }
}
