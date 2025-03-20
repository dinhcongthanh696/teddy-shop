package entity;

public class ContentManagement {
    private int id;
    private String headerTextColor;
    private String headerBackgroundColor;
    private String footerTextColor;
    private String footerBackgroundColor;
    private String webName;

    // Constructor
    public ContentManagement() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getHeaderTextColor() {
        return headerTextColor;
    }

    public void setHeaderTextColor(String headerTextColor) {
        this.headerTextColor = headerTextColor;
    }

    public String getHeaderBackgroundColor() {
        return headerBackgroundColor;
    }

    public void setHeaderBackgroundColor(String headerBackgroundColor) {
        this.headerBackgroundColor = headerBackgroundColor;
    }

    public String getFooterTextColor() {
        return footerTextColor;
    }

    public void setFooterTextColor(String footerTextColor) {
        this.footerTextColor = footerTextColor;
    }

    public String getFooterBackgroundColor() {
        return footerBackgroundColor;
    }

    public void setFooterBackgroundColor(String footerBackgroundColor) {
        this.footerBackgroundColor = footerBackgroundColor;
    }

    public String getWebName() {
        return webName;
    }

    public void setWebName(String webName) {
        this.webName = webName;
    }
}