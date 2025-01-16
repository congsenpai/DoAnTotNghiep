package com.smartparking.smartbrain.generalFunction;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import java.io.IOException;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

public class QRCodeGenerator {

    public static void generateQRCode(
            String username,
            String userID,
            int isMonthly,
            int into, // vao ra
            Double budget,
            String filePath
    ) throws WriterException, IOException {
        // Dữ liệu cần mã hóa dưới dạng JSON
        Map<String, Object> data = new HashMap<>();
        data.put("username", username);
        data.put("userID", userID);
        data.put("isMonthly", isMonthly);
        data.put("into", into);
        data.put("budget", budget);
        // Chuyển Map thành chuỗi JSON
        ObjectMapper objectMapper = new ObjectMapper();
        String text = objectMapper.writeValueAsString(data);
        // Tạo mã QR
        int width = 300;
        int height = 300;
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, width, height);
        // Lưu mã QR vào file
        Path path = FileSystems.getDefault().getPath(filePath);
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", path);
        System.out.println("QR Code đã được tạo thành công tại: " + filePath);
    }

    public static void main(String[] args) {
        try {
            String username = "JohnDoe";
            String userID = "12345";
            int isMonthly = 1;
            int into = 1;
            Double budget = 2500.0;
            String filePath = "qrcode.png";
            generateQRCode(username, userID, isMonthly, into, budget, filePath);
        } catch (WriterException | IOException e) {
            System.err.println("Lỗi khi tạo mã QR: " + e.getMessage());
        }
    }
}


