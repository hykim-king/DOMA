package com.acorn.doma.cmn;

import java.text.SimpleDateFormat;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.acorn.doma.code.domain.Code;

public class StringUtil  implements PLog {
	/**
	 *  날짜 Format
	 * @param format ex)yyyyMMddhhmmss
	 *               ex)yyyy-MM-dd
	 * @return string
	 */
	public static String getDate(String format){
		Date date =new Date();
		//format null처리 
		if(null==format || format.equals(""))format="yyyyMMdd";
		
		SimpleDateFormat  sdf=new SimpleDateFormat(format);
		
		return sdf.format(date);
	}
	/**
	 * 페이지 네이션
	 * @param maxNum : 총글수
	 * @param currentPageNo : 페이지 번호
	 * @param rowPerPage : 페이지 사이즈 -> 10/20/30/50/10/200
	 * @param bottomCount : 10/5
	 * @param url : 서버호출 URL
	 * @param scriptName : 자바스크립트 명
	 * @return paging Html
	 */
   public static String renderingPaging(int maxNum,int currentPageNo, int rowPerPage, int bottomCount,String url, String scriptName) {
	   StringBuilder html=new StringBuilder(2000);
	   
	   //전체 모양
	   //<< < 1 2 3...10 > >>
	   //-----------------------------------------------------------------------
	   
	   //maxNum =21
	   //currentPageNo = 1
	   //rowPerPage    = 10
	   //bottomCount   = 10
	   
	   int maxPageNo   = (maxNum -1)/rowPerPage + 1;//3
	   int startPageNo = ((currentPageNo -1)/bottomCount) * bottomCount +1   ;//1,11,21...
	   int endPageNo   = ((currentPageNo -1)/bottomCount+1) * bottomCount    ;//10,20,20...
	   
	   int nowBlocNo   = ((currentPageNo -1)/bottomCount)+1;//1
	   int maxBlockNo  = ((maxNum -1)/bottomCount)+1;//3
	   
	   //-----------------------------------------------------------------------
	   
	   if(currentPageNo>maxPageNo) {
		   return "";
	   }
	   
	   html.append("<ul class=\"pagination justify-content-center\"> \n");
	   //<<
	   

	   
	   if(nowBlocNo>1 && nowBlocNo <= maxBlockNo) {
		   log.debug("nowBlocNo:"+nowBlocNo);
		   log.debug("maxBlockNo:"+maxBlockNo);
		   
		   html.append("<li class=\"page-item\"> \n");          //scriptName(url,1);
		   html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',1);" +" \"> \n");
		   html.append("<span aria-hidden=\"true\">&laquo;</span> \n");
		   html.append("</a> \n");
		   
		   html.append("</li> \n");
	   }
	   
	   //<
	   if(startPageNo>bottomCount) {
		   log.debug("startPageNo:"+startPageNo);
		   log.debug("bottomCount:"+bottomCount);		   
		   
		   html.append("<li class=\"page-item\"> \n");
		   html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+(startPageNo - bottomCount)+ "); \" > \n");
		   html.append("<span aria-hidden=\"true\">&lt;</span> \n");
		   html.append("</a> \n");
		   
		   html.append("</li> \n");
	   }
	   //1 2 3 ... 10
	   int inx = 0;
	   
	   for(inx = startPageNo;inx<=maxPageNo && inx <= endPageNo;inx++ ) {
		   
		   if(inx == currentPageNo) {
			   html.append("<li class=\"page-item\"> \n");
			   html.append("<a class=\"page-link active\" href=\"#\">");
			   html.append(inx);
			   html.append("</a> \n");
			   html.append("</li> \n");
		   }else {
			   html.append("<li class=\"page-item\"> \n");
			   html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+inx+ "); \" >");
			   
			   html.append(inx);
			   html.append("</a> \n");
			   html.append("</li> \n");			   
		   }
		   
	   }
	   //>
	   if(maxPageNo>inx) {
		   log.debug("nowBlocNo:"+nowBlocNo);
		   log.debug("bottomCount:"+bottomCount);	
		   log.debug(">:"+ ((nowBlocNo * bottomCount)+1));	
		   
		   html.append("<li class=\"page-item\"> \n");
		   html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+((nowBlocNo * bottomCount)+1)+ "); \" >");		   
		   html.append("<span aria-hidden=\"true\">&gt;</span> \n");
		   html.append("</a> \n");
		   html.append("</li> \n");		   
	   }
	   //>>
	   if(maxPageNo>inx) { 
		   html.append("<li class=\"page-item\"> \n");
		   html.append("<a class=\"page-link\" href=\"javascript:"+scriptName+"('"+url+"',"+(maxPageNo)+ "); \" > \n");
		   html.append("<span aria-hidden=\"true\">&raquo;</span> \n");
		   html.append("</a> \n");
		   html.append("</li> \n");
	   }
	   
	   
	   
	   html.append("</ul>\n");
	   log.debug(html.toString());
	   return html.toString();
   }
	
	
	/**
	 * 
	 * @param pageCode
	 * @param selectedVal
	 * @return
	 */
	public static String getCodeList(List<Code> pageCode, String selectedVal) {
		StringBuilder sb=new StringBuilder(300);
		
        if(null != pageCode && pageCode.size()>0){
        	for(Code code :pageCode){     
        		String optionValue = "";   		
        		
        		if(code.getDetCode().equals(selectedVal)) {
        			optionValue = "<option  value='"+code.getDetCode()+"'  selected>"+code.getDetCode()+"</option>";
        		}else {
        			optionValue = "<option  value='"+code.getDetCode()+"'>"+code.getDetNm()+"</option>";
        		}
        		sb.append(optionValue+"\n");
        	}
        	log.debug(sb.toString());
        }
        
        
		
		return sb.toString();
	}
	
	/**
	 * request null처리 
	 * @param value
	 * @param defaultValue
	 * @return String
	 */
	public static String nvl( String value, String defaultValue) {
	    if(null == value || value.trim().isEmpty()){
	    	return defaultValue;
	    }
	    
		return value;
	}
	
	/**
	 * 32bit UUID 생성
	 * @return String
	 */
	public static String getUUID() {
		UUID uuidTemp = UUID.randomUUID();

		return uuidTemp.toString().replaceAll("-", "");
	}
}
