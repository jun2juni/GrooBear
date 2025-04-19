package kr.or.ddit.sevenfs.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

@Component
public class FileReaderUtil {
    @Value("${file.save.abs.path}")
    private String absPath = "/Users/heoseongjin/Documents/GitHub/ddit/05_LAST/upload/";

    public static void main(String[] args) {
        FileReaderUtil fileReaderUtil = new FileReaderUtil();


        fileReaderUtil.readZip("자료실/면접100제/edeafd57a08042c183bb4706aa669fa3_최프 공통코드 데이터 쿼리_25.03.26..sql.zip");
//        String s = fileReaderUtil.readFile(filePath, 100);

//        System.out.println(s);
    }


    public String readFile(String filePath, Integer lineNum) {
        File file = new File(absPath + filePath);
        if (file.exists()) {
            try {
                BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8));
                StringBuffer sb = new StringBuffer();
                String line = null;
//                while (((line = br.readLine()) != null)) {
//                    sb.append(line);
//                    sb.append(line + "\r\n");
//                }

                for (int i = 0; i < lineNum; i++) {
                    line = br.readLine();
                    if (line == null) break;;

                    sb.append(line);
                    sb.append(line + "\r\n");

                }

                return sb.toString();

            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        return "";
    }

    public List<byte[]> readPdfAll(String filePath) {
        File pdfFile = new File(absPath + filePath);
        try (PDDocument document = PDDocument.load(pdfFile)) {
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            List<byte[]> images = new ArrayList<>();

            for (int i = 0; i < document.getNumberOfPages(); i++) {
//            for (int i = 0; i < 3; i++) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(i, 50);
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(bim, "png", baos);
                images.add(baos.toByteArray());
            }

            return images;
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }



    public List<String> readZip(String filePath) {
        File file = new File(absPath + filePath);
        // /Users/heoseongjin/Documents/GitHub/ddit/05_LAST/upload/자료실/면접100제/edeafd57a08042c183bb4706aa669fa3_최프 공통코드 데이터 쿼리_25.03.26.zip
        System.out.println("0 " + file.getAbsolutePath());
        if (file.exists()) {
            try (ZipInputStream zis = new ZipInputStream(new FileInputStream(file))) {
                ZipEntry entry;
                while ((entry = zis.getNextEntry()) != null) {
                    System.out.println("1 " + entry.getName() + " " + entry.getSize() + " " + entry.getCompressedSize() + " " + entry.getCrc());
                }
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

        }

        return null;
    }
}
