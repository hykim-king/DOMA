package com.acorn.doma.cmn;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.acorn.doma.cmn.StringUtil;

public class DateUtil {

	public static String getCurrentDate(String pattern) {
		if(null == pattern || "".equals(pattern)) {
			pattern = "yyyyMMdd";
		}
		
		System.out.println("pattern:" + pattern);
		
		return LocalDateTime.now().format(DateTimeFormatter.ofPattern(pattern));
	}
	
	public static String getExt(String fileName) {
		String ext = "";
		
		//p.o.m.xml
		if(fileName.lastIndexOf(".") > -1) {
			int lastIndex = fileName.lastIndexOf(".");
			ext = fileName.substring(lastIndex+1);
		}
		
		System.out.println("ext:" + ext);
		return ext;
	}
	
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			System.out.println(StringUtil.getDateUUID("yyyyMMdd"));
		}
		
		String ext = getExt("p.o.m.xml");
		System.out.println(ext);
		
		String year = getCurrentDate("yyyy");
		System.out.println(year);
		
		String month = getCurrentDate("MM");
		System.out.println(month);
		
		String yyyyMMdd = getCurrentDate("");
		System.out.println(yyyyMMdd);
	}
	
	
	
}
