package com.yoon.excel.excelController;
import com.yoon.excel.excelService.excelService;


import com.google.gson.Gson;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;


@Controller
public class ExcelController {

    @Autowired
    private excelService excelService;

    @RequestMapping("/excel/excelUpload.do")
    @ResponseBody
    public void excelUpload(@RequestBody List<Map<String,String>> param) throws Exception {
    	
    	
    	System.out.println("testinsertExcel");
    	System.out.println(param);
    	
    	excelService.excelUpload(param);
    	
    	
    	
    	
    }
    
    
    }
    
    




