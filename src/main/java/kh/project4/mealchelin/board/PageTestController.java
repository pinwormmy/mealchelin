package kh.project4.mealchelin.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageTestController {
	@RequestMapping(value = "/testp/ctest", method = RequestMethod.GET)
	public void ctest(){
	}
}
