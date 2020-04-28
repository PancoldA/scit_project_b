package global.sesoc.wareware.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import global.sesoc.wareware.dao.PostingDAO;
import global.sesoc.wareware.vo.Posting;

@RestController
public class PostingController {
	
	@Autowired private PostingDAO dao;
	
	@GetMapping(value = "/posting/get", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<Posting>> getList(@RequestParam("experience") String experience, @RequestParam("education") String education, @RequestParam("locations[]") String[] locations) {
		
		return new ResponseEntity<List<Posting>>(dao.postingList(experience, education, locations), HttpStatus.OK);
	}
}
