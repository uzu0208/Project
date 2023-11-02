package com.controller;

import java.util.HashMap;
import java.util.Map;

import com.dto.MapDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.PageDTO;
import com.service.MapService;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MapController {

	@Autowired
	MapService service;

	@GetMapping("/main")
	// http://localhost:8090/app/main
	public String main(Model m, @RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage,
					   @RequestParam(value = "province", required = false, defaultValue = "창원") String province,
					   @RequestParam(value = "city", required = false, defaultValue = "성산구") String city,
					   @RequestParam(value = "citykey", required = false) String citykey,
					   @RequestParam(required = false, defaultValue = "") String searchFstvlNm) {

		Map<String, String> location = new HashMap<String, String>();
		location.put("province", province);
		location.put("city", city);
		location.put("citykey", citykey);
		location.put("searchFstvlNm", searchFstvlNm);

		PageDTO pagedto = service.findAll(curPage, location);
		m.addAttribute("pagedto", pagedto);

		return "main";
	}

	@GetMapping("/toCity")
	// http://localhost:8090/app/main
	public String toCity(Model m, @RequestParam String citykey) {

		Map<String, String> location = new HashMap<String, String>();
		PageDTO pagedto = new PageDTO();
		location.put("citykey", citykey);
		pagedto.setLocation(location);

		m.addAttribute("pagedto", pagedto);
		return "main";
	}

	@GetMapping("/retrieve")
	// http://localhost:8090/app/main
	public String Retrieve(Model m, @RequestParam String citykey) {

		Map<String, String> location = new HashMap<String, String>();
		PageDTO pagedto = new PageDTO();
		location.put("citykey", citykey);
		pagedto.setLocation(location);

		m.addAttribute("pagedto", pagedto);
		return "retrieve";
	}

	// 관리자 페이지에서 축제 데이터 보여줄 때 실행
	@GetMapping("/admin/admin")
	public String admin(Model m, @RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage,
						@RequestParam(value = "province", required = false, defaultValue = "") String province,
						@RequestParam(value = "city", required = false, defaultValue = "") String city,
						@RequestParam(value = "searchFstvlNm", required = false, defaultValue = "") String searchFstvlNm){

		Map<String, String> location = new HashMap<>();
		location.put("province", province);
		location.put("city", city);
		location.put("searchFstvlNm", searchFstvlNm);

		PageDTO pagedto = service.findAllAdmin(curPage, location);
		m.addAttribute("pagedto", pagedto);

		return "admin/adminForm";
	}

	// 축제 데이터 수정폼
	@GetMapping("retrieveForm/admin")
	public String retrieveForm(Model model, @RequestParam String fstvlNm, @RequestParam String opar,
							   @RequestParam String fstvlStartDate, @RequestParam String fstvlEndDate,
							   @RequestParam(defaultValue = "1") String curPage, @RequestParam(required = false) String city,
							   @RequestParam(required = false) String province){

		Map<String, String> map = new HashMap<>();
		map.put("fstvlNm", fstvlNm);
		map.put("opar", opar);
		map.put("fstvlStartDate", fstvlStartDate);
		map.put("fstvlEndDate", fstvlEndDate);

		MapDTO dto = service.findRetrieve(map);
		model.addAttribute("mapdto", dto);
		model.addAttribute("curPage", curPage);
		model.addAttribute("city",city);
		model.addAttribute("province", province);

		return "admin/retrieve";
	}

	// 축제데이터 입력폼
	@GetMapping("insertForm/admin")
	public String insertForm(){
		return "admin/insert";
	}

	// 축제 데이터의 기본키 중복 확인
	@GetMapping(value = "festivalDuplicatedCheck", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String festivalDuplicateCheck(@RequestParam String fstvlNm, @RequestParam String opar,
										 @RequestParam String fstvlStartDate, @RequestParam String fstvlEndDate){
		Map<String, String> map = new HashMap<>();
		map.put("fstvlNm", fstvlNm);
		map.put("opar", opar);
		map.put("fstvlStartDate", fstvlStartDate);
		map.put("fstvlEndDate", fstvlEndDate);

		MapDTO dto = service.findRetrieve(map);
		String mesg = "중복 없음";
		if (dto != null){
			mesg = "중복 있음";
		}

		return mesg;
	}

	// 축제 데이터 입력 폼의 데이터 삽입
	@PostMapping("insertData/admin")
	public String insertData(@RequestParam String fstvlNm, @RequestParam String opar, @RequestParam String fstvlStartDate,
							 @RequestParam String fstvlEndDate, @RequestParam String fstvlCo, @RequestParam String mnnst,
							 @RequestParam String auspcInstt, @RequestParam(required = false) String suprtInstt,
							 @RequestParam(required = false) String phoneNumber, @RequestParam(required = false) String homepageUrl,
							 @RequestParam(required = false) String relateInfo, @RequestParam(required = false) String rdnmadr,
							 @RequestParam(required = false) String lnmadr, @RequestParam(required = false) String latitude,
							 @RequestParam(required = false) String longitude, @RequestParam String referenceDate,
							 @RequestParam String insttCode, HttpServletRequest request){


		MapDTO dto = new MapDTO(fstvlNm, opar, fstvlStartDate, fstvlEndDate, fstvlCo, mnnst, auspcInstt, suprtInstt, phoneNumber,
								homepageUrl, relateInfo, rdnmadr, lnmadr, latitude, longitude, referenceDate, insttCode);

		int n = service.insertData(dto);

		return "redirect:/admin/admin";
	}

	// 축제 데이터 삭제하기
	@GetMapping("deleteData/admin")
	public String deleteData(@RequestParam String fstvlNm, @RequestParam String opar, @RequestParam String fstvlStartDate,
							 @RequestParam String fstvlEndDate, HttpServletRequest request,
							 @RequestParam(defaultValue = "1") String curPage, @RequestParam(required = false) String city,
							 @RequestParam(required = false) String province, @RequestParam(required = false) String searchFstvlNm,
							 RedirectAttributes redirectAttributes){

		Map<String, String> map = new HashMap<>();

		map.put("fstvlNm", fstvlNm);
		map.put("opar", opar);
		map.put("fstvlStartDate", fstvlStartDate);
		map.put("fstvlEndDate", fstvlEndDate);

		int n = service.deleteData(map);

		// 변경 후 관리자 페이지로 이동 시 전 페이지로 이동
		redirectAttributes.addAttribute("curPage", curPage);
		redirectAttributes.addAttribute("city", city);
		redirectAttributes.addAttribute("province", province);
		redirectAttributes.addAttribute("searchFstvlNm", searchFstvlNm);

		return "redirect:/admin/admin";
	}

	// 축제 데이터 수정하기
	@PostMapping("updateData/admin")
	public String updateData(@RequestParam String fstvlNm, @RequestParam String opar, @RequestParam String fstvlStartDate,
							 @RequestParam String fstvlEndDate, @RequestParam String fstvlCo, @RequestParam String mnnst,
							 @RequestParam String auspcInstt, @RequestParam(required = false) String suprtInstt,
							 @RequestParam(required = false) String phoneNumber, @RequestParam(required = false) String homepageUrl,
							 @RequestParam(required = false) String relateInfo, @RequestParam(required = false) String rdnmadr,
							 @RequestParam(required = false) String lnmadr, @RequestParam(required = false) String latitude,
							 @RequestParam(required = false) String longitude, @RequestParam String referenceDate,
							 @RequestParam String insttCode, @RequestParam(defaultValue = "1") String curPage,
							 @RequestParam(required = false) String city, @RequestParam(required = false) String province,
							 @RequestParam(required = false) String searchFstvlNm,
							 RedirectAttributes redirectAttributes){


		MapDTO dto = new MapDTO(fstvlNm, opar, fstvlStartDate, fstvlEndDate, fstvlCo, mnnst, auspcInstt, suprtInstt, phoneNumber,
								homepageUrl, relateInfo, rdnmadr, lnmadr, latitude, longitude, referenceDate, insttCode);

		int n = service.updateData(dto);

		// 변경 후 관리자 페이지로 이동 시 전 페이지로 이동
		redirectAttributes.addAttribute("curPage", curPage);
		redirectAttributes.addAttribute("city", city);
		redirectAttributes.addAttribute("province", province);
		redirectAttributes.addAttribute("searchFstvlNm", searchFstvlNm);

		return "redirect:/admin/admin";
	}
}
