package com.metanet.shopping.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.metanet.shopping.mapper.ItemImgMapper;

@RestController
public class ImageController {
	@Autowired
	ItemImgMapper itemImgMapper;
	
	@GetMapping(value = "/resources/images/{imageName}", produces = MediaType.IMAGE_PNG_VALUE)
	public @ResponseBody byte[] getImage(
		@PathVariable(name = "imageName") String imageName,
		//@PathVariable(name = "extension", required = false, value = "jpg") String extension,
		HttpServletRequest request) throws IOException {
		String imagePath = request.getServletContext().getRealPath("resources/images/" + imageName);
		InputStream imageStream = new FileInputStream(imagePath);
		byte[] imageByteArray = IOUtils.toByteArray(imageStream);
		imageStream.close();

		return imageByteArray;
	}
}
