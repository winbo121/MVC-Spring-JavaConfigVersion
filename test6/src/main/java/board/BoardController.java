package board;





import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import config.PagingResult;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping( value="/start.do" ,method= RequestMethod.GET)
	public String index(@ModelAttribute BoardVO search, Model model) {

		PagingResult<Map<String, Object>> result =  boardService.list(search);

		model.addAttribute("paging", result);
		model.addAttribute("search", search);
		
		return "index";
	}
	
	@RequestMapping( value="/insertPro.do", method= RequestMethod.GET)
	public String insertPro(@ModelAttribute BoardVO search, Model model) {
		model.addAttribute("search", search);
		return "index_detail";
	}
	
	@RequestMapping( value="/insert.do" ,method= RequestMethod.POST)
	@ResponseBody
	public void insert(@ModelAttribute @Valid BoardVO search, Model model) {
		log.info("search --> {}", search );
		boardService.insert(search);
	}
	
	@ResponseBody
	@RequestMapping( value="/delete.do" ,method= RequestMethod.POST)
	public void delete(@RequestParam(value="del_list[]") List<String> del_list ) {
		boardService.delete(del_list);
	}
	
	
	@RequestMapping( value="/read.do" , method= RequestMethod.GET)
	public String read(@ModelAttribute BoardVO search, Model model ) {
		
		BoardVO readBoard=boardService.read(search);
		log.info("readBoard --> {}", readBoard );
		model.addAttribute("readBoard", readBoard);
		model.addAttribute("search", search);
		return "index_detail";
	}
	
	@RequestMapping( value="/update.do" ,method= RequestMethod.POST)
	@ResponseBody
	public void update(@ModelAttribute BoardVO search) {
		boardService.update(search);
	}

}
