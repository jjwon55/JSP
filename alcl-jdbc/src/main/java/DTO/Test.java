package DTO;

import com.alohaclass.jdbc.annotation.Pk;
import com.alohaclass.jdbc.annotation.Table;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Table("test")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Test {
	@Pk
	private int no;
	private String name;
	private int age;
	private String mainTitle;
}
