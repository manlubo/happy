package com.gitbaby.happygivers.controller;

import com.gitbaby.happygivers.domain.Attach;
import com.gitbaby.happygivers.util.S3Util;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("upload")
@AllArgsConstructor
public class UploadController {
  private S3Util s3Util;

  @PostMapping
  public List<Attach> upload(@RequestParam("uploadFile") List<MultipartFile> files) {
    List<Attach> attachs = new ArrayList<>();
    int odr = 0;

    for (MultipartFile file : files) {
      if (file.isEmpty()) continue;

      String origin = file.getOriginalFilename();
      String contentType = file.getContentType();
      boolean image = contentType != null && contentType.startsWith("image");

      // 확장자 추출
      String ext = "";
      int idx = origin.lastIndexOf(".");
      if (idx >= 0) {
        ext = origin.substring(idx).toLowerCase();
      }

      String uuid = UUID.randomUUID().toString();
      String fileName = uuid + ext;
      String path = genPath();

      // S3 업로드
      s3Util.upload(file, "upload/" + path + "/" + fileName);


      attachs.add(Attach.builder()
        .uuid(fileName)
        .origin(origin)
        .image(image)
        .path(path)
        .odr(odr++)
        .build());
    }

    return attachs;
  }


  private String genPath() {
    LocalDate now = LocalDate.now();
    return now.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
  }


}
