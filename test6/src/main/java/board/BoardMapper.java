package board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface BoardMapper{

	
	public List<Map<String,Object>> select(BoardVO vo);
	public Integer selectCnt(BoardVO vo);
	public void insert(BoardVO vo);
	public BoardVO read(BoardVO vo);
	public void update(BoardVO vo);
	public void delete(@Param("del_list") List<String> del_list);
	
}
