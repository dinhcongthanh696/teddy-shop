package dao;

import entity.Size;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SizeDAO extends DBConnection {
    
    public ArrayList<Size> getAllSizes() {
        ArrayList<Size> sizeList = new ArrayList<>();
        String sql = """
                     WITH DistinctSizes AS (
                         SELECT DISTINCT [name],
                                CAST(SUBSTRING(name, 1, LEN(name) - 2) AS INT) AS SizeValue
                         FROM Size
                     )
                     SELECT [name]
                     FROM DistinctSizes
                     ORDER BY SizeValue;""";
        
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                Size size = new Size();
                size.setName(rs.getString("name"));
                sizeList.add(size);
            }
        } catch (SQLException e) {
            System.out.println("Error getting sizes: " + e.getMessage());
        }
        
        return sizeList;
    }
}