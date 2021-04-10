package board;



import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import config.BaseService;
import config.PagingResult;




@Service
public class BoardService extends BaseService{
	
	@Autowired
	private BoardMapper boardMapper;
	
	public PagingResult<Map<String, Object>> list (BoardVO vo){
		
		List<Map<String,Object>> pagedList= boardMapper.select(vo);
		Integer totalCount = boardMapper.selectCnt(vo);
		
		return super.convertJspPaging(vo, pagedList, totalCount);
	}
	
	public void insert (BoardVO vo) {
		boardMapper.insert(vo);
	}
	
	public BoardVO read (BoardVO vo) {
		return boardMapper.read(vo);
	}
	
	public void update(BoardVO vo) {
		boardMapper.update(vo);
	}
	
	public void delete (List<String> del_list) {
		boardMapper.delete(del_list);
	}
}
