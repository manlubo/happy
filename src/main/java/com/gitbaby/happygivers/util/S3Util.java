package com.gitbaby.happygivers.util;


import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;


import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Data
@Component
public class S3Util {
  private final String accessKey;
  private final String secretKey;
  private final String bucketName;
  private final String regionName;
  private final S3Client s3;

  @Autowired
  public S3Util(
    @Value("${spring.aws.s3.access-key}") String accessKey,
    @Value("${spring.aws.s3.secret-key}") String secretKey,
    @Value("${spring.aws.s3.bucket-name}") String bucketName,
    @Value("${spring.aws.s3.region-name}") String regionName
  ) {
    this.accessKey = accessKey;
    this.secretKey = secretKey;
    this.bucketName = bucketName;
    this.regionName = regionName;

    this.s3 = S3Client.builder()
      .region(Region.of(regionName))
      .credentialsProvider(
        StaticCredentialsProvider.create(
          AwsBasicCredentials.create(accessKey, secretKey)
        )
      ).build();
  }

//  public static void main(String[] args) {
//    System.out.println(s3);
//
//    PutObjectRequest por = PutObjectRequest.builder()
//      .bucket(s3Config.getBucketName())
//      .key("pom.xml")
//      .contentType("text/xml")
//      .build();
//    s3.putObject(por, RequestBody.fromFile(new File("C:\\Users\\tj\\git\\happygivers2\\pom.xml")));
//  }


  public void upload(MultipartFile part, String key) {
    try {
      uploadInternal(part.getInputStream(), key, part.getSize(), part.getContentType());
    } catch (IOException e) {
      throw new RuntimeException("S3 업로드 실패", e);
    }
  }


//	public static void upload(File file, String key) {
//		try {
//			uploadInternal(new FileInputStream(file), key, file.length(), Files.probeContentType(file.toPath()));
//		} catch (IOException e) {
//			throw new RuntimeException("S3 업로드 실패", e);
//		}
//	}


  private void uploadInternal(InputStream is, String key, long size, String contentType) {
    PutObjectRequest putReq = PutObjectRequest.builder()
      .bucket(bucketName)
      .key(key)
      .contentType(contentType != null ? contentType : "application/octet-stream")
      .build();

    try (is) {
      s3.putObject(putReq, RequestBody.fromInputStream(is, size));
    } catch (IOException e) {
      throw new RuntimeException("S3 업로드 중 오류", e);
    }
  }


  public void remove(String key) {
    try {
      DeleteObjectRequest deleteReq = DeleteObjectRequest.builder()
        .bucket(bucketName)
        .key(key)
        .build();

      s3.deleteObject(deleteReq);

    } catch (Exception e) {

      throw new RuntimeException("S3 삭제 중 오류", e);
    }
  }

  public int removeAll(List<String> keys) {
    int deletedCount = 0;

    for (String key : keys) {
      try {
        DeleteObjectRequest deleteReq = DeleteObjectRequest.builder()
          .bucket(bucketName)
          .key(key)
          .build();
        s3.deleteObject(deleteReq);
        deletedCount++;
        log.info("[S3 DELETE] {}", key);
      } catch (Exception e) {
        log.warn("S3 삭제 실패: {}", key, e);
      }
    }

    return deletedCount;
  }


  public List<String> listObjects(String prefix) {
    ListObjectsV2Request req = ListObjectsV2Request.builder()
      .bucket(bucketName)
      .prefix(prefix) // 예: "upload/2025/07/08/"
      .build();

    ListObjectsV2Response res = s3.listObjectsV2(req);
    return res.contents().stream()
      .map(S3Object::key)
      .collect(Collectors.toList());
  }


}
