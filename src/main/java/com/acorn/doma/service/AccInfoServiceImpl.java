package com.acorn.doma.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.locationtech.proj4j.ProjCoordinate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.acorn.doma.cmn.DTO;
import com.acorn.doma.cmn.PLog;
import com.acorn.doma.domain.Accident;
import com.acorn.doma.mapper.AccMapper;
import com.acorn.doma.proj4j.CoordinateConverter;

@Service
public class AccInfoServiceImpl implements AccInfoService, PLog{
	
	private final String serviceKey;
	
	@Autowired
	AccMapper accMapper;
	
	public void AccInfoServiceImple() {
		
	}
	@Autowired
	    public AccInfoServiceImpl(AccMapper accMapper, @Qualifier("accInfoServiceKey") String serviceKey) {
	        this.accMapper = accMapper;
	        this.serviceKey = serviceKey;
	}
	 

	
	

	@Override
	public List<Accident> fullTableScan() throws SQLException {
		
		List<Accident> list = accMapper.fullTableScan();
		log.debug("┌ list ┐");
		for(Accident acc : list) {
			log.debug("│ "+ acc);
		}
		log.debug("└ ");
		
		return list;
	}
	@Override
	public List<Accident> doRetrieve(DTO search) throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public int doUpdate(Accident inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int doDelete(Accident inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public int doSave(Accident inVO) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public Accident doSelectOne(Accident inVO) throws SQLException, NullPointerException {
		log.debug("1. param :"+inVO);
		Accident outVO = accMapper.doSelectOne(inVO);
		log.debug("2. outVO :"+outVO);
		return outVO;
	}
	
	
	@Override
	public List<Accident> A01Retrieve() throws SQLException {
		List<Accident> list = accMapper.A01Retrieve();
		return list;
	}
	@Override
	public List<Accident> A04Retrieve() throws SQLException {
		List<Accident> list = accMapper.A04Retrieve();
		return list;
	}
	@Override
	public List<Accident> A02Retrieve() throws SQLException {
		List<Accident> list = accMapper.A02Retrieve();
		return list;
	}
	@Override
	public List<Accident> A10Retrieve() throws SQLException {
		List<Accident> list = accMapper.A10Retrieve();
		return list;
	}
	@Override
	public List<Accident> A11Retrieve() throws SQLException {
		List<Accident> list = accMapper.A11Retrieve();
		return list;
	}
	@Override
	public List<Accident> A03Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Accident> A05Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Accident> A06Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Accident> A07Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Accident> A08Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Accident> A09Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<Accident> A12Retrieve() throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

}
