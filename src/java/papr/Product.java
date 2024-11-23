package papr;

public class Product {
    private String id; // Product ID
    private String name;
    private double price;
    private String image;
    private String brandName; // Brand name
    private String productDescription; // Product description
    
    public Product(String id, String image, String name, double price,String brandName,String productDescription) {
        this.id = id;
        this.image = image;
        this.name = name;
        this.price = price;
        this.brandName = brandName;
        this.productDescription = productDescription;
    }

    // Constructor
     public Product(String id, String image, double price, String name, String brandName, String productDescription) {
        this.id = id;
        this.image = image;
        this.name = name;
        this.price = price;
        this.brandName = brandName;
        this.productDescription = productDescription;
    }

    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(String productDescription) {
        this.productDescription = productDescription;
    }
} 