package kh.project4.mealchelin.product;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import kh.project4.mealchelin.mapper.CommentMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(value = "/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	@Autowired
	private ProductService productService;

	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void productListPage(@ModelAttribute("cri") ProductCriteria cri, Model model) throws Exception {
		logger.info("/product/listAll");
		logger.info(cri.toString());
		model.addAttribute("productList", productService.selectListWithPaging(cri));
		ProductPageMaker pageMaker = new ProductPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.listCountCriteria(cri));
		model.addAttribute("pageMaker", pageMaker);
	}

	@RequestMapping(value = "/listType")
	public void productListType(Model model, @RequestParam(value = "typeCode") String typeCode) throws Exception {
		logger.info("/product/listType" + typeCode);
		List<ProductVO> productList = productService.selectByTypeCode(typeCode);
		ProductTypeVO pType = productService.selectTypeByTypeCode(typeCode);
		model.addAttribute("productList", productList);
		model.addAttribute("productType", pType);
	}

	@RequestMapping(value = "/detail")
	public void productDetail(Model model, @RequestParam(value = "pId") int pId, HttpServletRequest request)
			throws Exception {
		logger.info("/product/detail ????????????: " + pId);
		ProductDetailVO productOne = productService.selectProductDetail(pId);
		List<ProductVO> relatedList = productService.selectRelatedList(pId);
		model.addAttribute("productOne", productOne);
		model.addAttribute("relatedList", relatedList);
	}

	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public void search(Model model, @RequestParam(value = "keyword") String keyword) throws Exception {
		logger.info("/product/search -> '" + keyword + "' ??????");
		List<ProductVO> productList = productService.search(keyword);
		model.addAttribute("productList", productList);
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(HttpServletRequest request, ProductVO product, Model model) {
		logger.info("// /product/register get??????");
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPost(HttpServletRequest request, ProductVO product) throws Exception {
		logger.info("// /product/register post?????? : {}", product);
		productService.insert(product);
		logger.info("// product.toString()=" + product.toString());
		request.setAttribute("msg", "???????????? ??????");
		request.setAttribute("url", "adminProduct");
		return "alert";

	}
	
	@RequestMapping(value = "/adminProduct")
	public String adminProduct(@ModelAttribute("cri") ProductSearchCriteria cri, Model model) throws Exception {
		logger.info("/product/adminProduct");
		model.addAttribute("productList", productService.adminListSearch(cri));
		ProductPageMaker pageMaker = new ProductPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(productService.adminListSearchCount(cri));
		logger.info(cri.toString());
		model.addAttribute("pageMaker", pageMaker);
		return "product/adminProduct";
	}

	@RequestMapping(value = "/listAdmin")
	public void productListAdmin(HttpServletRequest request, Model model) throws Exception {
		logger.info("/product/listAdmin");
		List<ProductVO> productList = productService.selectProductList();
		logger.info("// productList.toString()=" + productList.toString());
		model.addAttribute("productList", productList);
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public void updateGET(HttpServletRequest request, @RequestParam(value = "pId") int pId, Model model)
			throws Exception {
		logger.info("/product/update get ?????? pId=" + pId);
		ProductDetailVO productOne = productService.selectProductDetail(pId);
		model.addAttribute("productOne", productOne);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updatePOST(HttpServletRequest request, ProductVO product, Model model) throws Exception {
		logger.info("/product/update post ??????");
		int pId = product.getPId();
		productService.updateProduct(product);
		ProductDetailVO productOne = productService.selectProductDetail(pId);
		logger.info("// productList.toString()=" + productOne.toString());
		request.setAttribute("msg", "???????????? ??????");
		request.setAttribute("url", "adminProduct");
		return "alert";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(HttpServletRequest request, int pId) throws Exception {
		logger.info("/product/delete : {}", pId);
		productService.delete(pId);
		request.setAttribute("msg", "???????????? ??????");
		request.setAttribute("url", "adminProduct");
		return "alert";
	}

	/* ?????? ?????? ????????? */
	@RequestMapping(value = "/uploadAjaxAction", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(@RequestPart(value = "file") MultipartFile[] uploadFile) {
		logger.info("uploadAjaxActionPOST..........");
		/* ????????? ?????? ?????? */
		for(MultipartFile multipartFile: uploadFile) {
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(!type.startsWith("image")) {
				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
		}
		String uploadFolder = "upload";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);
		File uploadPath = new File(uploadFolder, datePath);
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		/* ????????? ?????? ?????? ?????? */
		List<AttachImageVO> list = new ArrayList();
		for(MultipartFile multipartFile : uploadFile) {
			AttachImageVO vo = new AttachImageVO();
			/* ?????? ?????? */
			String uploadFileName = multipartFile.getOriginalFilename();	
			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			/* uuid ?????? ?????? ?????? */
			String uuid = UUID.randomUUID().toString();
			vo.setUuid(uuid);
			uploadFileName = uuid + "_" + uploadFileName;
			/* ?????? ??????, ?????? ????????? ?????? File ?????? */
			File saveFile = new File(uploadPath, uploadFileName);
			/* ?????? ?????? */
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				e.printStackTrace();
			} 
			list.add(vo);
		}
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		return result;
	}

	
	@RequestMapping(value = "/display", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getImage(String fileName){
		File file = new File("upload" + fileName);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/* ????????? ?????? ?????? */
	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		logger.info("deleteFile........" + fileName);
		File file = null;
		try {
			/* ????????? ?????? ?????? */
			file = new File("upload" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			/* ?????? ?????? ?????? */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			logger.info("originFileName : " + originFileName);
			file = new File(originFileName);
			file.delete();
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
}
