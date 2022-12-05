package com.yoon.excel.excelService;


import com.yoon.mapper.excelMapper;

import java.io.File;
import java.io.IOException;
import java.util.*;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.yoon.excel.excelDAO.excelDAO;

@Service
public class excelServiceImpl implements excelService{

    @Autowired
    excelMapper excelMapper;
    
   
    @Resource
    private excelDAO excelDAO;
    
    @Override
    public void excelUpload(List<Map<String,String>> data) throws Exception{
    	Map<String,String> result = data.get(0);
    	excelDAO.excelUpload(result);
    } 

    
    
}
