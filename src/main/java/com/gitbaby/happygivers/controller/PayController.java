package com.gitbaby.happygivers.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gitbaby.happygivers.domain.DonateAction;
import com.gitbaby.happygivers.domain.Pay;
import com.gitbaby.happygivers.domain.PayLog;
import com.gitbaby.happygivers.domain.en.Mtype;
import com.gitbaby.happygivers.domain.en.PayStatus;
import com.gitbaby.happygivers.domain.en.PayType;
import com.gitbaby.happygivers.service.PayService;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("api/payment")
public class PayController {
  @Value("${spring.portone.secret}")
  private String API_SECRET;

  @Autowired
  private ObjectMapper objectMapper;

  @Autowired
  PayService payService;


  static class PaymentRequest {
    public String paymentId;
    public String amount;
  }


  // 토큰 받아오기
  private String getAccessToken() throws IOException {
    // 1. 요청 URL 설정
    URL url = new URL("https://api.portone.io/login/api-secret");
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();

    // 2. HTTP 요청 설정
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setRequestProperty("Accept", "application/json");
    conn.setDoOutput(true);

    // 3. 요청 바디 구성
    JsonObject json = new JsonObject();
    json.addProperty("apiSecret", API_SECRET);

    // 4. 요청 전송
    try (OutputStream os = conn.getOutputStream()) {
      os.write(json.toString().getBytes(StandardCharsets.UTF_8));
    }

    // 5. 응답 코드 확인 후 InputStream 선택
    int code = conn.getResponseCode();
    InputStream input = (code >= 200 && code < 300) ? conn.getInputStream() : conn.getErrorStream();

    // 6. 응답 JSON 파싱 및 access_token 추출
    try (InputStreamReader isr = new InputStreamReader(input, StandardCharsets.UTF_8)) {
      JsonObject response = JsonParser.parseReader(isr).getAsJsonObject();

      // 🔍 디버깅용 로그 출력
      System.out.println("🟢 PortOne 응답: " + response);

      // 7. access_token 존재 여부 확인
      if (response.has("accessToken")) {
        return response.get("accessToken").getAsString();
      } else {
        throw new IOException("❌ accessToken 누락 - PortOne 응답 오류: " + response.toString());
      }
    }
  }


  // 결제 관리(성공, 취소)
  @PostMapping("complete")
  protected ResponseEntity<Map<String, Object>> pay(@RequestBody PaymentRequest data) {
    String paymentId = data.paymentId;

    try {
      String token = getAccessToken();

      URL url = new URL("https://api.portone.io/payments/" + paymentId);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("GET");
      conn.setRequestProperty("Authorization", "Bearer " + token);

      int responseCode = conn.getResponseCode();

      JsonObject result = null;
      if (responseCode == 200) {
        result = JsonParser.parseReader(new InputStreamReader(conn.getInputStream())).getAsJsonObject();
        log.info("{}", result);

        String status = result.get("status").getAsString(); // 예: PAID, FAILED
        log.info("{}", status);

        // 커스텀 데이터 파싱
        String customDataRaw = result.get("customData").getAsString();

        JsonObject customData = JsonParser.parseString(customDataRaw).getAsJsonObject();

        // donateaction 인스턴스 생성
        long drno = customData.get("drno").getAsLong();
        long mno = customData.get("mno").getAsLong();

        int realAmount = 0;
        if (result.has("amount") && result.get("amount").isJsonObject()) {
          JsonObject amountObj = result.getAsJsonObject("amount");
          if (amountObj.has("total") && !amountObj.get("total").isJsonNull()) {
            String totalStr = amountObj.get("total").getAsString().split("\\.")[0];
            realAmount = Integer.parseInt(totalStr);
          }
        }
        int amount = realAmount * 1000;
        DonateAction action = DonateAction.builder().drno(drno).mno(mno).amount(amount).build();


        // pay 인스턴스 생성
        String paytype = "ETC";
        if (result.get("method") != null) {
          if (result.get("method").getAsJsonObject().get("provider") != null) {
            paytype = result.get("method").getAsJsonObject().get("provider").getAsString();
          }
        }


        List<String> useTypes = new ArrayList<String>(List.of("CARD", "TOSSPAY", "KAKAOPAY", "TRANSFER"));
        if (!useTypes.contains(paytype)) {
          paytype = "ETC";
        }
        // 영수증 없으면 널값
        String receipt = "";
        if (result.get("receiptUrl") != null) {
          receipt = result.get("receiptUrl").getAsString();
        }

        String uuid = result.get("id").getAsString();
        Pay pay = Pay.builder().mno(mno).payamount(amount).paytype(PayType.valueOf(paytype)).paystatus(PayStatus.valueOf(status)).receipt(receipt).uuid(uuid).build();
        log.info("{}", pay);
        // paylog 인스턴스 생성
        String pgResponseRaw = "";
        String resultMsg = "";
        if (result.get("pgResponse") != null) {
          pgResponseRaw = result.get("pgResponse").getAsString();
          JsonObject pgResponse = JsonParser.parseString(pgResponseRaw).getAsJsonObject();
          resultMsg = pgResponse.get("ResultMsg").getAsString();
        }

        PayLog paylog = PayLog.builder().paystatus(PayStatus.valueOf(status)).result(resultMsg).mtype(Mtype.USER).build();


        log.info("{} :: {} :: {}", action, pay, paylog);


        payService.register(action, pay, paylog);
      }


      Map<String, Object> fullMap = objectMapper.readValue(result.toString(), new TypeReference<>() {
      });


      // 4. 응답 JSON 전송

      return ResponseEntity.ok(fullMap);


    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(500).body(Map.of("msg", "서버 오류", "error", e.getMessage()));
    }
  }


  // 환불 관리
  @PostMapping("refund")
  protected ResponseEntity<Map<String, Object>> refund(@RequestBody PaymentRequest data) {
    String paymentId = data.paymentId;

    int amount = 0;
    if (data.amount != null) {
      amount = Integer.valueOf(data.amount) / 1000;
    }
    log.info("환불 요청 ID: {}, 금액: {}", paymentId, amount);

    try {
      String token = getAccessToken();

      // PortOne 환불API 요청
      URL url = new URL("https://api.portone.io/payments/" + paymentId + "/cancel");
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setRequestProperty("Authorization", "Bearer " + token);
      conn.setRequestProperty("Content-Type", "application/json");
      conn.setDoOutput(true);

      JsonObject refundBody = new JsonObject();
      refundBody.addProperty("reason", "관리자 요청");
      refundBody.addProperty("storeId", "store-f1ff113e-a12f-48a2-ad88-1a67d77bd7ad");
      refundBody.addProperty("amount", amount);
      refundBody.addProperty("requester", "ADMIN");

      try (OutputStream os = conn.getOutputStream()) {
        os.write(refundBody.toString().getBytes(StandardCharsets.UTF_8));
        os.flush();
      }

      int responseCode = conn.getResponseCode();

      JsonObject result = null;
      if (responseCode == 200) {
        result = JsonParser.parseReader(new InputStreamReader(conn.getInputStream())).getAsJsonObject();
        log.info("{}", result);

        String status = "";
        String cancelId = "";
        String reason = "";

        if (result.has("cancellation") && result.get("cancellation").isJsonObject()) {
          JsonObject cancellation = result.getAsJsonObject("cancellation");

          // 취소 uuid로 pay개체 가져와서 status 변경 후 업데이트,
          Pay pay = payService.findByUuid(paymentId);
          pay.setPaystatus(PayStatus.REFUND);

          reason = cancellation.get("reason").getAsString();
          // pay로그 인스턴트 생성
          PayLog log = PayLog.builder().pno(pay.getPno()).paystatus(pay.getPaystatus()).result(reason).mtype(Mtype.ADMIN).build();


          payService.modify(pay, log);
        }

      }

      Map<String, Object> fullMap = objectMapper.readValue(result.toString(), new TypeReference<>() {
      });

      return ResponseEntity.ok(fullMap);

    } catch (Exception e) {
      e.printStackTrace();
      return ResponseEntity.status(500).body(Map.of("msg", "서버 오류", "error", e.getMessage()));
    }

  }

}
