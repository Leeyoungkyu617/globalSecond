package project.spring.member.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.beans.CsvServiceBean;

@Controller
@RequestMapping("/csv/")
public class CSVController {
	
	@Autowired
	private CsvServiceBean csvService = null;
	
	@RequestMapping("writerCsv")
	public String writeCSV(HttpServletRequest request){
//		csvService
		List<String[]> data = new ArrayList<String[]>();
		data.add(new String[] {"abc","def","ghi","jkl"});
		data.add(new String[] {"1","23","456","7890"});
		String savePath = request.getRealPath("resources\\csv");
		savePath += "\\testscv.csv";
		csvService.writeCSV(data,savePath);
		return "/util/csvTest";
	}
	
	@RequestMapping("readCsv")
	public String readCSV(){
		csvService.readCSV();
		return "/util/csvTest";
	}
}
