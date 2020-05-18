Public class prodClass{
Public static List<productList> prodList;
public class productList{

    public String id;
    public Boolean replacement;
    public Integer quantity;
    public String name;
    public Integer maintenanceperiod;
    public Integer lifespan;
    public Integer cost;
    public String sku;

    
    
}

public static prodClass parse(String json) {
        return (prodClass) System.JSON.deserialize(json, prodClass.class);
    }
}