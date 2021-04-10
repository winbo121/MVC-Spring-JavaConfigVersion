package board;






import config.PagingSearch;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter @Setter
@ToString(callSuper = true)
public class BoardVO extends PagingSearch{
	
	private String name;
	private String password;
	private String search_text;
}
	
	
	
	


