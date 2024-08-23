package com.acorn.doma.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.service.AccInfoService;
import com.acorn.doma.service.BoardService;
import com.acorn.doma.service.CodeService;
import com.acorn.doma.service.MarkdownService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("main")
public class MainController implements PLog {
	@Autowired
	AccInfoService accInfoService;
	
	@Autowired
	BoardService boardService;

	@Autowired
	MarkdownService markdownService;

	@Autowired
	CodeService codeService;
	
	public MainController() {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ MainController()             │");
		log.debug("└──────────────────────────────┘");
	}
	
	//http://localhost:8080/doma/main/emergency.do
	@RequestMapping(value="/main.do"
					,method=RequestMethod.GET
					,produces = "text/plain;charset=UTF-8")
	public String emergency(Model model) throws SQLException {
		log.debug("┌──────────────────────────────┐");
		log.debug("│ main()                       │");
		log.debug("└──────────────────────────────┘");
		
		String viewName = "main/main_emergency_info";

		List<Accident> accList = accInfoService.fullTableScan();
		
		model.addAttribute("accList", accList);
		
		List<Accident> A01List = accInfoService.A01Retrieve();
		model.addAttribute("A01List", A01List);
		List<Accident> A02List = accInfoService.A02Retrieve();
		model.addAttribute("A02List", A02List);
		List<Accident> A03List = accInfoService.A03Retrieve();
		model.addAttribute("A03List", A03List);
		List<Accident> A04List = accInfoService.A04Retrieve();
		model.addAttribute("A04List", A04List);
		List<Accident> A05List = accInfoService.A05Retrieve();
		model.addAttribute("A05List", A05List);
		List<Accident> A06List = accInfoService.A06Retrieve();
		model.addAttribute("A06List", A06List);
		List<Accident> A07List = accInfoService.A07Retrieve();
		model.addAttribute("A07List", A07List);
		List<Accident> A08List = accInfoService.A08Retrieve();
		model.addAttribute("A08List", A08List);
		List<Accident> A09List = accInfoService.A09Retrieve();
		model.addAttribute("A09List", A09List);
		List<Accident> A10List = accInfoService.A10Retrieve();
		model.addAttribute("A10List", A10List);
		List<Accident> A11List = accInfoService.A11Retrieve();
		model.addAttribute("A11List", A11List);
		List<Accident> A12List = accInfoService.A12Retrieve();
		model.addAttribute("A12List", A12List);
		return viewName;
	}
	public String getCctvData(double latitude, double longitude) {
	    double minLat = latitude - 0.2;
	    double maxLat = latitude + 0.2;
	    double minLng = longitude - 0.2;
	    double maxLng = longitude + 0.2;

	    String url = UriComponentsBuilder.fromHttpUrl("https://openapi.its.go.kr:9443/cctvInfo")
	            .queryParam("apiKey", "6e714cfc324348298bb670b85ceb30a8")
	            .queryParam("type", "its")
	            .queryParam("cctvType", "1")
	            .queryParam("minX", minLng)
	            .queryParam("maxX", maxLng)
	            .queryParam("minY", minLat)
	            .queryParam("maxY", maxLat)
	            .queryParam("getType", "json")
	            .toUriString();

	    log.debug("Request URL: " + url);

	    RestTemplate restTemplate = new RestTemplate();
	    String response = restTemplate.getForObject(url, String.class);

	    log.debug("Response from CCTV API: " + response);

	    return response;
	}
	public JSONObject findNearestCctv(double latitude, double longitude, String cctvJson) {
		JSONObject result = new JSONObject(cctvJson);
	    JSONArray cctvArray = result.getJSONObject("response").getJSONArray("data");

	    log.debug("CCTV Data Array: " + cctvArray.toString());

	    double minDistance = Double.MAX_VALUE;
	    JSONObject nearestCctv = null;

	    for (int i = 0; i < cctvArray.length(); i++) {
	        JSONObject cctv = cctvArray.getJSONObject(i);
	        double cctvLat = cctv.getDouble("coordy");
	        double cctvLng = cctv.getDouble("coordx");

	        double distance = Math.sqrt(Math.pow(latitude - cctvLat, 2) + Math.pow(longitude - cctvLng, 2));
	        log.debug("CCTV " + i + " - Latitude: " + cctvLat + ", Longitude: " + cctvLng + ", Distance: " + distance);

	        if (distance < minDistance) {
	            minDistance = distance;
	            nearestCctv = cctv;
	        }
	    }

	    log.debug("Nearest CCTV: " + (nearestCctv != null ? nearestCctv.toString() : "None"));

	    return nearestCctv;
	}
	@RequestMapping(value = "/getNearestCctv.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	@ResponseBody
	public String getNearestCctv(@RequestParam("accId") String accId) {
	    log.debug("Received accId: " + accId);
	    Accident accident = new Accident();
	    accident.setAccId(accId);
	    Accident inVO = new Accident();
	    try {
	        // 사고 정보 조회
	    	inVO = accInfoService.doSelectOne(accident);
	        ObjectMapper objectMapper = new ObjectMapper();
	        String accData = objectMapper.writeValueAsString(inVO);
	        log.debug("Accident data: " + inVO);
	        log.debug("Parsed Accident object: " + inVO.toString());
	    } catch (SQLException e) {
	        log.error("Error retrieving accident data", e);
	        return "Error retrieving accident data";
	    } catch (JsonProcessingException e) {
	        log.error("Error converting to JSON", e);
	        return "Error converting to JSON";
	    }

	    // CCTV 데이터 조회
	    String cctvDataJson = getCctvData(inVO.getLatitude(), inVO.getLongitude());
	    log.debug("CCTV Data JSON: " + cctvDataJson);

	    JSONObject nearestCctv = findNearestCctv(inVO.getLatitude(), inVO.getLongitude(), cctvDataJson);

	    // 결과 반환
	    return nearestCctv != null ? nearestCctv.toString() : "No CCTV found";
	}
	@GetMapping("/guide.do")
	public String guidePage() {
		String viewName = "/guide/guide"; // JSP 페이지 경로
		log.debug("┌──────────────────────────────────────────┐");
		log.debug("│ viewName: " + viewName);
		log.debug("└──────────────────────────────────────────┘");
		return viewName;
	}
	

}
