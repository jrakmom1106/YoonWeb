package com.yoon.excel.excelService;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface excelService {
    
	
	void excelUpload(List<Map<String, String>> param) throws Exception;

}
