package com.yoon.mapper;


import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface excelMapper {
    
	void excelUpload(List<Map<String, String>> param);
}
