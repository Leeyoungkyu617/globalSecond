package project.spring.sales.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.sales.service.SalesService;

@Controller
@RequestMapping("/sales")
public class SalesController {

	@Autowired
	SalesService salesService = null;
	
	@RequestMapping(value ="/index")
	public String indexSs(HttpServletRequest request, String pageNum, Model model) {
		System.out.println("SalesIndex Controller");
		if(pageNum == null) {
			pageNum = "1";
		}
		int pageSize=10;
		int currPage = Integer.parseInt(pageNum);	
		int startRow = (currPage -1) * pageSize + 1;
		int endRow = currPage * pageSize;		
		int count = 0;			
		int number = 0;
		
		HttpSession session = request.getSession();
		String memId = (String)session.getAttribute("memId");
		System.out.println("Session : " + memId);
		
		String userKindCh = null;
		userKindCh = salesService.userIdCh(memId);
		System.out.println("판매자니 ? "+userKindCh);
		if(!userKindCh.equals("sales")) {
			System.out.println("판매자가 아니어서 리턴하겠습니다");
			return "redirect:/";
		}
		
		count = salesService.salesCount(memId);
		System.out.println("count : " + count);
		
		List salesList = null;
		
		if(count > 0) {
			salesList = salesService.productorList(memId, startRow, endRow);
			System.out.println("salesList" + salesList.toString());
		}
		number = count - (currPage -1) * pageSize;
		
		model.addAttribute("number", new Integer(number));
		model.addAttribute("pageSize", new Integer(pageSize));
		model.addAttribute("pageNum", new Integer(pageNum));
		model.addAttribute("currPage", new Integer(currPage));
		model.addAttribute("startRow", new Integer(startRow));
		model.addAttribute("endRow", new Integer(endRow));
		model.addAttribute("count", new Integer(count));
		model.addAttribute("salesList", salesList);
		
		
		
		return "sales/index.mn";
	}
	
	
}