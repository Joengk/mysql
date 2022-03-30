package pojo;

import lombok.*;

import javax.xml.crypto.Data;


//@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class User {
    private Integer id;
    private String username;
    private Data birthday;
    private String sex;
    private String address;
}
